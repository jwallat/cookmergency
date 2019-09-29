import 'package:cookmergency/src/models/recipe_model.dart';

abstract class AbstractRecipeProvider {
  Future<List<String>> fetchIngredients();

  Future<List<String>> fetchIngredientTypes();

  Future<RecipeModel> fetchRecipe(int id);

  Future<List<int>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients);

  Future<bool> addRecipe(RecipeModel recipe);

  Future<List<String>> fetchRecipeTypes();
}
