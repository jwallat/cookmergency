import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase database;
  IngredientAmountDao ingredientAmountDao;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    ingredientAmountDao = IngredientAmountDao(database);

    IngredientTypeDao ingredientTypeDao = IngredientTypeDao(database);
    await ingredientTypeDao.insertIngredientType(
        IngredientTypesCompanion(name: Value("SOME_TYPE")));
    IngredientDao ingredientDao = IngredientDao(database);
    await ingredientDao.insertIngredient(IngredientsCompanion(
        ingredientType: Value("SOME_TYPE"), name: Value("SOME_INGREDIENT")));
    await ingredientDao.insertIngredient(IngredientsCompanion(
        ingredientType: Value("SOME_TYPE"), name: Value("SOME_INGREDIENT2")));

    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);
    await recipeTypeDao.insertRecipeType(
        RecipeTypesCompanion(name: Value('SOME_RECIPE_TYPE')));
    RecipeDao recipeDao = RecipeDao(database);
    await recipeDao.insertRecipe(
      RecipesCompanion(
        title: Value("SOME_RECIPE"),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('SOME_RECIPE_TYPE'),
        preparationTime: Value('19'),
      ),
    );

    await recipeDao.insertRecipe(
      RecipesCompanion(
        title: Value("SOME_RECIPE2"),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('SOME_RECIPE_TYPE'),
        preparationTime: Value('19'),
      ),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('IngredientName references ingredient table', () async {
    expect(
        () async => ingredientAmountDao.insertIngredientAmount(
            IngredientAmountsCompanion(
                ingredientName: Value("OTHER_INGREDIENT"),
                recipeTitle: Value("SOME_RECIPE"),
                amount: Value(2),
                amountUnit: Value("SOME_UNIT"))),
        throwsA(isA<SqliteException>().having((e) => e.message, "message",
            contains("FOREIGN KEY constraint failed"))));
  });

  test('recipeTitle refereneces recipe table', () async {
    expect(
        () async => ingredientAmountDao.insertIngredientAmount(
            IngredientAmountsCompanion(
                ingredientName: Value("SOME_INGREDIENT"),
                recipeTitle: Value("OTHER_RECIPE"),
                amount: Value(2),
                amountUnit: Value("SOME_UNIT"))),
        throwsA(isA<SqliteException>().having((e) => e.message, "message",
            contains("FOREIGN KEY constraint failed"))));
  });

  test(
      'getAllIngredientAmountsForRecipe returns all ingredient amounts for that specific recipe',
      () async {
    await ingredientAmountDao.insertIngredientAmount(
      IngredientAmountsCompanion(
        ingredientName: Value("SOME_INGREDIENT"),
        recipeTitle: Value("SOME_RECIPE"),
        amount: Value(2),
        amountUnit: Value("SOME_UNIT"),
      ),
    );

    ingredientAmountDao.insertIngredientAmount(
      IngredientAmountsCompanion(
        ingredientName: Value("SOME_INGREDIENT2"),
        recipeTitle: Value("SOME_RECIPE"),
        amount: Value(2),
        amountUnit: Value("SOME_UNIT"),
      ),
    );

    expect(
        (await ingredientAmountDao
                .getAllIngredientAmountsForRecipe("SOME_RECIPE"))
            .length,
        2);
  });

  test(
      'getAllIngredientAmountsForRecipe returns no ingredient amounts for other recipes',
      () async {
    await ingredientAmountDao.insertIngredientAmount(
      IngredientAmountsCompanion(
        ingredientName: Value("SOME_INGREDIENT"),
        recipeTitle: Value("SOME_RECIPE"),
        amount: Value(2),
        amountUnit: Value("SOME_UNIT"),
      ),
    );

    ingredientAmountDao.insertIngredientAmount(
      IngredientAmountsCompanion(
        ingredientName: Value("SOME_INGREDIENT2"),
        recipeTitle: Value("SOME_RECIPE2"),
        amount: Value(2),
        amountUnit: Value("SOME_UNIT"),
      ),
    );

    expect(
        (await ingredientAmountDao
                .getAllIngredientAmountsForRecipe("SOME_RECIPE"))
            .length,
        1);
  });

  test('insertIngredientAmount adds a new IngredientAmount', () async {
    ingredientAmountDao.insertIngredientAmount(
      IngredientAmountsCompanion(
        ingredientName: Value("SOME_INGREDIENT"),
        recipeTitle: Value("SOME_RECIPE"),
        amount: Value(2),
        amountUnit: Value("SOME_UNIT"),
      ),
    );

    List<IngredientAmount> ias = await ingredientAmountDao
        .getAllIngredientAmountsForRecipe("SOME_RECIPE");

    expect(ias[0].amountUnit, "SOME_UNIT");
  });

  test('deleteIngredientAmount removes a IngredientAmount', () async {
    ingredientAmountDao.insertIngredientAmount(
      IngredientAmountsCompanion(
        ingredientName: Value("SOME_INGREDIENT"),
        recipeTitle: Value("SOME_RECIPE"),
        amount: Value(2),
        amountUnit: Value("SOME_UNIT"),
      ),
    );

    print((await ingredientAmountDao
            .getAllIngredientAmountsForRecipe("SOME_RECIPE"))
        .length);

    ingredientAmountDao.deleteIngredientAmount(
      IngredientAmountsCompanion(
        recipeTitle: Value("SOME_RECIPE"),
        ingredientName: Value("SOME_INGREDIENT"),
      ),
    );

    List<IngredientAmount> ias = await ingredientAmountDao
        .getAllIngredientAmountsForRecipe("SOME_RECIPE");

    expect(ias.length, 0);
  });
}
