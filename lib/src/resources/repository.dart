import "dart:async";
import "../models/ingredient_model.dart";
import "../models/recipe_model.dart";
import "../resources/remote_recipe_provider.dart";

class Repository {
  /// Handle item fetching and saving

  Repository();

  Future<void> initRemoteConnection() async {
    print("initDBConnection");
    await remoteRecipeProvider.initConnection();
  }

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

  Future<bool> addRecipe(
      String title,
      String recipeType,
      String preperationText,
      String imageURL,
      List<IngredientAmountModel> chosenIngredients) async {
    // should probably await the add functions to ensure correct insertion order

    // TODO: Add recipeType
    if (await remoteRecipeProvider.addRecipeType(recipeType)) {
      print("recipetype $recipeType added");
    } else {
      print("Error adding receipeType $recipeType");
      return false;
    }
    // TODO: Add recipe
    if (await remoteRecipeProvider.addRecipeToDB(
        title, recipeType, preperationText, imageURL)) {
      print("recipe-item $title added");
    } else {
      print("Error adding recipe $title");
      return false;
    }
    // TODO: Add single ingredients
    for (IngredientAmountModel model in chosenIngredients) {
      if (await remoteRecipeProvider.addIngredient(model.ingredientName)) {
        print("ingredient added: ${model.ingredientName}");
      } else {
        print("Error adding ${model.ingredientName}");
        return false;
      }
    }
    // TODO: Add IngredientAmounts
    for (IngredientAmountModel ia in chosenIngredients) {
      if (await remoteRecipeProvider.addIngredientAmountModel(ia)) {
        print(
            "ingredientAmountModel added (${ia.ingredientName}, ${ia.amount}, ${ia.unit})");
      } else {
        print("Error adding (${ia.ingredientName}, ${ia.amount}, ${ia.unit})");
        return false;
      }
    }

    return true;
  }

  bool removeRecipe(String title) {
    return false;
  }
}
