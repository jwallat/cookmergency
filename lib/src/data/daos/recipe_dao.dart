import 'package:cookmergency/src/data/tables/recipes.dart';
import 'package:cookmergency/src/data/tables/ingredientAmounts.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../moor_database.dart';

part 'recipe_dao.g.dart';

@UseDao(tables: [Recipes, IngredientAmounts])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  final AppDatabase db;

  RecipeDao(this.db) : super(db);

  Future insertRecipe(Insertable<Recipe> recipe) =>
      into(recipes).insert(recipe);

  Future updateRecipe(Insertable<Recipe> recipe) =>
      update(recipes).replace(recipe);
  Future deleteRecipe(Insertable<Recipe> recipe) =>
      delete(recipes).delete(recipe);

  Future<Recipe> fetchRecipe(int id) =>
      (select(recipes)..where((recipe) => recipe.id.equals(id))).getSingle();

  Future<List<int>> getRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    List<int> recipeIds = [];

    String recipeTypes = "";
    for (String recipeType in chosenRecipeTypes) {
      recipeTypes += "'$recipeType',";
    }

    String ingredients = "";
    for (String ingredient in chosenIngredients) {
      ingredients += "'$ingredient',";
    }
    if (recipeTypes.isNotEmpty && ingredients.isNotEmpty) {
      recipeTypes = recipeTypes.substring(0, recipeTypes.length - 1) ?? "";
      ingredients = ingredients.substring(0, ingredients.length - 1) ?? "";
    }

    String query;

    if (recipeTypes.isNotEmpty && ingredients.isNotEmpty) {
      query = "SELECT DISTINCT r.id FROM IngredientAmounts ia "
          "JOIN Recipes r ON (ia.recipeTitle = r.recipeTitle) WHERE r.recipeTypeName IN ($recipeTypes)"
          "AND ia.recipeTitle NOT IN "
          "("
          "SELECT ib.recipeTitle "
          "FROM IngredientAmounts ib "
          "WHERE ib.ingredientName NOT IN ($ingredients)"
          ")";
    } else {
      // Future<List<int>> ids = select(recipes)..map((Recipe r) => r.id).get();
    }

    List<QueryRow> rows = await db.customSelect(query);
    rows.forEach((row) => recipeIds.add(row.readInt("id")));

    return recipeIds;
  }
}
