import 'package:cookmergency/src/data/tables/recipeIds.dart';
import 'package:cookmergency/src/data/tables/recipes.dart';
import 'package:cookmergency/src/data/tables/ingredientAmounts.dart';
import 'package:moor/moor.dart';
import '../moor_database.dart';
import 'dart:async';

part 'recipe_dao.g.dart';

@UseDao(tables: [Recipes, RecipeIds, IngredientAmounts])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  final AppDatabase db;

  RecipeDao(this.db) : super(db);

  Future insertRecipe(Insertable<Recipe> recipe) =>
      into(recipes).insert(recipe).then((id) =>
          into(recipeIds).insert(RecipeIdsCompanion(localId: Value(id))));

  Future deleteRecipe(Insertable<Recipe> recipe) {
    return delete(recipes).delete(recipe);
  }

  Future<Recipe> fetchRecipe(int id) =>
      (select(recipes)..where((recipe) => recipe.id.equals(id))).getSingle();

  Future<List<Recipe>> fetchRecipesForTypes(
      List<String> chosenRecipeTypes) async {
    if (chosenRecipeTypes.isEmpty) {
      return await (select(recipes)).get();
    }
    return await (select(recipes)
          ..where((r) => r.recipeType.isIn(chosenRecipeTypes)))
        .get();
  }

  Future<List<IngredientAmount>> _fetchInvalidIas(
      List<String> chosenIngredients) {
    Future<List<IngredientAmount>> invalidIas = Future.value([]);
    if (chosenIngredients.isEmpty) {
      return invalidIas;
    }
    return (select(ingredientAmounts)
          ..where((ia) => ia.ingredientName.isNotIn(chosenIngredients)))
        .get();
  }

  Future<List<int>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    if (chosenRecipeTypes.isEmpty && chosenIngredients.isEmpty) {
      // return all ids
      return select(recipes).map((recipe) => recipe.id).get();
    } else {
      // complex query
      List<int> recipeIds = [];
      // get all recipes for that recipeType
      List<Recipe> recipes = await fetchRecipesForTypes(chosenRecipeTypes);
      print("Recipes: $recipes");
      // for that recipes, get all the one that do not contain any ingredients that are in chosen ingredients
      List<IngredientAmount> invalidIas =
          await _fetchInvalidIas(chosenIngredients);
      print("InvalidIAs: $invalidIas");

      for (Recipe recipe in recipes) {
        if (!invalidIas.any((ele) => ele.recipeTitle == recipe.title)) {
          recipeIds.add(recipe.id);
        }
      }

      return recipeIds;
    }

    //   return (select(recipes)
    //         ..join([
    //           leftOuterJoin(ingredientAmounts,
    //               recipes.title.equalsExp(ingredientAmounts.recipeTitle))
    //         ])
    //         ..where((r) => r.recipeType.isIn(chosenRecipeTypes))
    //         // select titles which don't have any ingredients that are not in chosenIngredients
    //         ..where((r) {
    //           // select all recipetitles of recipes that have ingredients that have not been choosen
    //           Future<List<IngredientAmount>> invalidIas =
    //               (select(ingredientAmounts)
    //                     ..where((ia) =>
    //                         ia.ingredientName.isNotIn(chosenIngredients)))
    //                   .get();
    //           invalidIas.then((invalidIas) {
    //             List<String> invalidIaRecipeTitles =
    //                 invalidIas.map((ia) => ia.recipeTitle).toList();
    //             // if recipe title not in the invalid list --> cool, else filter out
    //             return r.title.isNotIn(invalidIaRecipeTitles);
    //           });
    //           print("exit");
    //           return isNull(r.id);
    //         }))
    //       .map((recipe) => recipe.id)
    //       .get();
    // }

    // String query;

    // if (recipeTypes.isNotEmpty && ingredients.isNotEmpty) {
    //   query = "SELECT DISTINCT r.id FROM IngredientAmounts ia "
    //       "JOIN Recipes r ON (ia.recipeTitle = r.recipeTitle) WHERE r.recipeTypeName IN ($recipeTypes)"
    //       "AND ia.recipeTitle NOT IN "
    //       "("
    //       "SELECT ib.recipeTitle "
    //       "FROM IngredientAmounts ib "
    //       "WHERE ib.ingredientName NOT IN ($ingredients)"
    //       ")";
    // } else {
    //   // Future<List<int>> ids = select(recipes)..map((Recipe r) => r.id).get();
    // }
  }
}
