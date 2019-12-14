import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

// import 'test_db.dart';

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
    final id = await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value("type")));
    final recipeTypes = await recipeTypeDao.fetchAllRecipeTypes();

    expect(recipeTypes[0].name, 'type');
  });

  test('duplicate recipeTypes produce an error', () async {
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);
    final id = await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value("type")));

    expect(
        () async => await recipeTypeDao
            .insertRecipeType(RecipeTypesCompanion(name: Value("type"))),
        throwsA(isA<SqliteException>()));
  });
}
