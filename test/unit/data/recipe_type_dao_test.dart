import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase database;

  setUp(() {
    database = AppDatabase(VmDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('recipeTypes can be added', () async {
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);
    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value("type")));
    final recipeTypes = await recipeTypeDao.fetchAllRecipeTypes();

    expect(recipeTypes[0].name, 'type');
  });

  test('UNIQUE constraint test - duplicate recipeTypes produce an error',
      () async {
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);
    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value("type_constraint")));

    expect(
        () async => await recipeTypeDao.insertRecipeType(
            RecipeTypesCompanion(name: Value("type_constraint"))),
        throwsA(isA<SqliteException>()));
  });

  test('fetchAllRecipeTypes returns the correct number of elements', () async {
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);

    final int numRecipeTypesBefore =
        (await recipeTypeDao.fetchAllRecipeTypes()).length;

    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value("type1")));

    final recipeTypes = await recipeTypeDao.fetchAllRecipeTypes();

    expect(recipeTypes.length, numRecipeTypesBefore + 1);
  });

  test('deleteRecipeType removes the recipeType', () async {
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);

    final int numRecipeTypesBefore =
        (await recipeTypeDao.fetchAllRecipeTypes()).length;

    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value("type_delete")));

    expect((await recipeTypeDao.fetchAllRecipeTypes()).length,
        numRecipeTypesBefore + 1);

    await recipeTypeDao
        .deleteRecipeType(RecipeTypesCompanion(name: Value("type_delete")));

    expect((await recipeTypeDao.fetchAllRecipeTypes()).length,
        numRecipeTypesBefore);
  });
}
