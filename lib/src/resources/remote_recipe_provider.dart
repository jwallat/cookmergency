import "dart:async";
import 'package:cookmergency/src/models/recipe_id_model.dart';

import "../models/ingredient_model.dart";
import "../models/recipe_model.dart";

class RemoteRecipeProvider {
  RemoteRecipeProvider();

  Future<RecipeModel> fetchRecipe(int id) async {
    return null;
  }

  Future<List<String>> fetchRecipeTypes() async {
    return [];
  }

  Future<List<String>> fetchIngredientTypes() async {
    return [];
  }

  Future<List<String>> fetchIngredients() async {
    return [];
  }

  Future<List<RecipeIdModel>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    // TODO: Query Server over here
    //List<int> remoteIds = <int>[];

    return [];
  }

  Future<bool> addRecipeType(String recipeType) async {
    return false;
  }

  Future<bool> addRecipe(RecipeModel recipe) async {
    return false;
  }

  Future<bool> addIngredient(String name) async {
    return false;
  }

  Future<bool> addIngredientAmountModel(IngredientAmountModel model) async {
    return false;
  }
}
