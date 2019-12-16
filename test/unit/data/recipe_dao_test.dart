import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase database;
  RecipeDao recipeDao;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    recipeDao = RecipeDao(database);

    // Create recipe to test against
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);
    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value('type')));
    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value('other_type')));
  });

  tearDown(() async {
    await database.close();
  });

  test('recipeType has a reference constraint', () async {
    expect(
        () async => await recipeDao.insertRecipe(
              RecipesCompanion(
                id: Value(1),
                title: Value('Title'),
                imageUrl: Value('url'),
                preparationText: Value('text'),
                recipeType: Value('invalid_type'),
                preparationTime: Value('19'),
              ),
            ),
        throwsA(isA<SqliteException>().having((e) => e.message, "message",
            contains("FOREIGN KEY constraint failed"))));
  });

  test('recipeTitle has to be unique', () async {
    await recipeDao.insertRecipe(
      RecipesCompanion(
        id: Value(13),
        title: Value('SAME_TITLE'),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('type'),
        preparationTime: Value('19'),
      ),
    );

    expect(
        () async => await recipeDao.insertRecipe(
              RecipesCompanion(
                id: Value(1),
                title: Value('SAME_TITLE'),
                imageUrl: Value('url'),
                preparationText: Value('text'),
                recipeType: Value('type'),
                preparationTime: Value('19'),
              ),
            ),
        throwsA(isA<SqliteException>().having((e) => e.message, "message",
            contains("UNIQUE constraint failed"))));
  });

  test('insertRecipe inserts a new recipe', () async {
    await recipeDao.insertRecipe(
      RecipesCompanion(
        id: Value(999),
        title: Value('SOME_TITLE'),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('type'),
        preparationTime: Value('19'),
      ),
    );

    expect((await recipeDao.fetchRecipe(999)).title, "SOME_TITLE");
  });

  test('insertRecipe with a title longer than 70 causes an error ', () async {
    String longTitle =
        "012345689 012345689 012345689 012345689 012345689 012345689 012345689 012345689";
    print(longTitle.length);

    expect(
        () async => await recipeDao.insertRecipe(
              RecipesCompanion(
                id: Value(1),
                title: Value(longTitle),
                imageUrl: Value('url'),
                preparationText: Value('text'),
                recipeType: Value('type'),
                preparationTime: Value('19'),
              ),
            ),
        throwsA(isA<InvalidDataException>().having(
            (e) => e.message, "message", contains("title: Must at most be"))));
  });

  test('insertRecipe with a missing value causes an error ', () async {
    expect(
        () async => await recipeDao.insertRecipe(
              RecipesCompanion(
                id: Value(1),
                imageUrl: Value('url'),
                preparationText: Value('text'),
                recipeType: Value('type'),
                preparationTime: Value('19'),
              ),
            ),
        throwsA(isA<InvalidDataException>().having((e) => e.message, "message",
            contains("title: This value was required"))));
  });

  test('deleteRecipe deletes a recipe', () async {
    await recipeDao.insertRecipe(
      RecipesCompanion(
        id: Value(10101),
        title: Value("title"),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('type'),
        preparationTime: Value('19'),
      ),
    );

    await recipeDao.deleteRecipe(
      RecipesCompanion(
        id: Value(10101),
      ),
    );

    expect(await recipeDao.fetchRecipe(10101), null);
  });

  test('insertRecipe inserts a new recipe', () async {
    await recipeDao.insertRecipe(
      RecipesCompanion(
        id: Value(999),
        title: Value("NEW_RECIPE"),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('type'),
        preparationTime: Value('19'),
      ),
    );

    expect((await recipeDao.fetchRecipe(999)).title, "NEW_RECIPE");
  });

  test(
      'fetchRecipeIds with no selected ingredients and types, returns all recipes',
      () async {
    // add some ingredients, ias, recipes with different types
    // TODO: Finish tests as soon as other tables have been tested
  });

  test(
      'fetchRecipeIds with only types selected retuns only recipes with the correct types',
      () async {});

  test(
      'fetchRecipeIds with selected ingredients retuns all recipes that only contain these recipes',
      () async {});
}
