import "dart:async";
import 'package:cookmergency/src/models/recipe_id_model.dart';
import 'package:tuple/tuple.dart';

import "../models/ingredient_model.dart";
import "../models/recipe_model.dart";
import "../resources/remote_recipe_provider.dart";
import "../resources/local_recipe_provider.dart";

class Repository {
  /// Handle item fetching and saving
  final LocalRecipeProvider localRecipeProvider = LocalRecipeProvider();
  final RemoteRecipeProvider remoteRecipeProvider = RemoteRecipeProvider();

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
    // Load recipeIds from remote DB
    List<RecipeIdModel> idModels = await remoteRecipeProvider.fetchRecipeIds(
        chosenRecipeTypes, chosenIngredients);
    // Load recipeIds from local db

    idModels.addAll(await localRecipeProvider.fetchRecipeIds(
        chosenRecipeTypes, chosenIngredients));
    // Return all id-elements

    return idModels;
  }

  Future<RecipeModel> fetchRecipe(RecipeIdModel idModel) {
    if (idModel.localId >= 0) {
      return localRecipeProvider.fetchRecipe(idModel.localId);
    } else {
      return remoteRecipeProvider.fetchRecipe(idModel.remoteId);
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

    return localRecipeProvider.addRecipe(recipe);

    // Add to remote queue
  }

  bool removeRecipe(String title) {
    return false;
  }
}
