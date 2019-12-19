import "dart:async";
import 'package:cookmergency/src/models/recipe_id_model.dart';
import 'package:tuple/tuple.dart';

import "../models/ingredient_amount_model.dart";
import "../models/recipe_model.dart";
import "../resources/remote_recipe_provider.dart";
import "../resources/local_recipe_provider.dart";

/// Handle item fetching and saving
class Repository {
  LocalRecipeProvider localRecipeProvider = LocalRecipeProvider();
  RemoteRecipeProvider remoteRecipeProvider = RemoteRecipeProvider();

  Repository();

  Repository.fromProviders(
      {this.localRecipeProvider, this.remoteRecipeProvider});

  Future<void> initRemoteConnection() async {
    // await remoteRecipeProvider.initConnection();
  }

  Tuple2<Future<List<String>>, Future<List<String>>> fetchIngredients() {
    return Tuple2<Future<List<String>>, Future<List<String>>>(
        localRecipeProvider.fetchIngredients(),
        remoteRecipeProvider.fetchIngredients());
  }

  Tuple2<Future<List<String>>, Future<List<String>>> fetchIngredientTypes() {
    return Tuple2<Future<List<String>>, Future<List<String>>>(
        localRecipeProvider.fetchIngredientTypes(),
        remoteRecipeProvider.fetchIngredientTypes());
  }

  Tuple2<Future<List<String>>, Future<List<String>>> fetchRecipeTypes() {
    return Tuple2<Future<List<String>>, Future<List<String>>>(
        localRecipeProvider.fetchRecipeTypes(),
        remoteRecipeProvider.fetchRecipeTypes());
  }

  Future<List<RecipeIdModel>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    List<RecipeIdModel> idModels = [];

    // Load recipeIds from remote DB
    List<RecipeIdModel> remoteIdModels = await remoteRecipeProvider
        .fetchRecipeIds(chosenRecipeTypes, chosenIngredients);

    // Load recipeIds from local db
    List<RecipeIdModel> localIdModels = await localRecipeProvider
        .fetchRecipeIds(chosenRecipeTypes, chosenIngredients);

    // Add remoteIds to localDB
    await localRecipeProvider.addRemoteRecipeIds(remoteIdModels);

    // Return all id-elements
    idModels.addAll(remoteIdModels);
    idModels.addAll(localIdModels);
    return idModels;
  }

  Future<RecipeModel> fetchRecipe(RecipeIdModel idModel) async {
    if (idModel.localId != null) {
      return localRecipeProvider.fetchRecipe(idModel.localId);
    } else {
      RecipeModel recipe =
          await remoteRecipeProvider.fetchRecipe(idModel.remoteId);
      localRecipeProvider.addRecipe(recipe);
      return recipe;
    }
  }

  Future<bool> addRecipe(
      String title,
      String recipeType,
      String preparationText,
      String imageURL,
      List<IngredientAmountModel> chosenIngredients) async {
    RecipeModel recipe = RecipeModel.fromData(
      title: title,
      type: recipeType,
      preparationText: preparationText,
      imgUrl: imageURL,
      ingredients: chosenIngredients,
    );

    remoteRecipeProvider.addRecipe(recipe);
    return localRecipeProvider.addRecipe(recipe);

    // Add to remote queue
  }

  bool removeRecipe(String title) {
    return false;
  }
}
