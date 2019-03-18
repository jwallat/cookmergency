import "dart:async";
import "../models/recipe_model.dart";
import "../resources/remote_recipe_provider.dart";

class Repository {
  /// Handle item fetching and saving

  Future<List<String>> fetchIngredients() {
    return remoteRecipeProvider.fetchIngredients();
  }

  Future<List<String>> fetchIngredientTypes() {
    return remoteRecipeProvider.fetchIngredientTypes();
  }

  Future<List<String>> fetchRecipeTypes() async {
    return remoteRecipeProvider.fetchRecipeTypes();
  }

  Future<List<int>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    return remoteRecipeProvider.fetchRecipeIds(
        chosenRecipeTypes, chosenIngredients);
  }
}
