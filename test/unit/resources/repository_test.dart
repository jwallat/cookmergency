import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class IngredientAmountDaoMock extends Mock implements IngredientAmountDao {}

class IngredientDaoMock extends Mock implements IngredientDao {}

void main() {
  test("fetchIngredients fetches from local DB and remote DB", () async {});

  test("fetchIngredients adds remote ingredients to local db", () async {});

  test("fetchIngredientTypes fetches from local DB and remote DB", () async {});

  test("fetchIngredientTypes adds remote ingredientTypes to local db",
      () async {});

  test("fetchRecipeTypes fetches from local DB and remote DB", () async {});

  test("fetchRecipeTypes adds remote recipeTypes to local db", () async {});

  test("fetchRecipeIds fetches from local DB and remote DB", () async {});

  test("fetchRecipeIds adds remote ids to local db", () async {});

  test("fetchRecipe fetches from local DB and remote DB", () async {});

  test("fetchRecipe adds remote recipeTypes to local db", () async {});

  test("addRecipe adds a recipe to local DB", () async {});

  test("addRecipe adds the recipe to remote DB", () async {
    // if a direct sync fails, persist information and try later
  });
}
