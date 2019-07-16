import "dart:async";
import "../models/ingredient_model.dart";
import "../models/recipe_model.dart";
import "../resources/remote_recipe_provider.dart";

class Repository {
  /// Handle item fetching and saving

  Repository();

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

  Future<RecipeModel> fetchRecipe(int id) {
    return remoteRecipeProvider.fetchRecipe(id);
  }

  bool addRecipe(String title, String recipeType, String preperationText,
      String imageURL, List<IngredientAmountModel> chosenIngredients) {
    // should probably await the add functions to ensure correct insertion order

    // TODO: Add recipeType
    remoteRecipeProvider.addRecipeType(recipeType);
    print("recipetype added");
    // TODO: Add recipe
    remoteRecipeProvider.addRecipeToDB(
        title, recipeType, preperationText, imageURL);
    print("recipe-item added");
    // TODO: Add single ingredients
    for (IngredientAmountModel model in chosenIngredients) {
      remoteRecipeProvider.addIngredient(model.ingredientName);
      print("ingredient added: ${model.ingredientName}");
    }
    // TODO: Add IngredientAmounts
    chosenIngredients.forEach(remoteRecipeProvider.addIngredientAmountModel);
    return false;
  }
}
