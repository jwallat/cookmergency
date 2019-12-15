import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_ids_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase database;
  RecipeIdDao recipeIdDao;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    recipeIdDao = RecipeIdDao(database);

    // Create recipe to test against
    RecipeTypeDao recipeTypeDao = RecipeTypeDao(database);
    await recipeTypeDao
        .insertRecipeType(RecipeTypesCompanion(name: Value('type')));

    RecipeDao recipeDao = RecipeDao(database);
    await recipeDao.insertRecipe(
      RecipesCompanion(
        id: Value(1),
        title: Value('Title'),
        imageUrl: Value('url'),
        preparationText: Value('text'),
        recipeType: Value('type'),
        preparationTime: Value('19'),
      ),
    );
  });

  tearDown(() async {
    await database.close();
  });

  test('remoteId has a unique constraint', () async {
    await recipeIdDao.insertId(RecipeIdsCompanion(remoteId: Value(0)));

    expect(
        () async =>
            await recipeIdDao.insertId(RecipeIdsCompanion(remoteId: Value(0))),
        throwsA(isA<SqliteException>()));
  });

  test('localId references a recipe (constraint)', () async {
    // Throws exception if no matching recipe is in db
    expect(
        () async =>
            await recipeIdDao.insertId(RecipeIdsCompanion(remoteId: Value(0))),
        throwsA(isA<SqliteException>()));
  });

  test('localId has a unique constraint', () async {
    await recipeIdDao.insertId(RecipeIdsCompanion(localId: Value(1)));

    expect(
        () async =>
            await recipeIdDao.insertId(RecipeIdsCompanion(localId: Value(1))),
        throwsA(isA<SqliteException>()));
  });

  test('recipeId can be added', () async {
    await recipeIdDao.insertId(RecipeIdsCompanion(
      id: Value(1),
      localId: Value(1),
    ));

    List<RecipeId> ids = await recipeIdDao.fetchAllRecipeIds();
    RecipeId id = ids.firstWhere((id) => id.localId == 1);

    expect(id.localId, 1);
  });

  test('recipeId can be updated', () async {
    await recipeIdDao.insertId(RecipeIdsCompanion(
      id: Value(1),
      localId: Value(1),
    ));

    await recipeIdDao.updateId(RecipeIdsCompanion(
      id: Value(1),
      localId: Value(1),
      remoteId: Value(-1),
    ));

    List<RecipeId> ids = await recipeIdDao.fetchAllRecipeIds();
    print(ids);
    RecipeId id = ids.firstWhere((id) => id.localId == 1);

    expect(id.remoteId, -1);
  });

  test('recipeId can be deleted', () async {
    await recipeIdDao.insertId(RecipeIdsCompanion(
      id: Value(1),
      localId: Value(1),
    ));

    List<RecipeId> ids = await recipeIdDao.fetchAllRecipeIds();

    await recipeIdDao.deleteId(RecipeIdsCompanion(id: Value(1)));

    expect((await recipeIdDao.fetchAllRecipeIds()).length, ids.length - 1);
  });
}
