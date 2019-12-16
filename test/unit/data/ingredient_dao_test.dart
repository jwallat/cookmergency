import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase database;
  IngredientDao ingredientDao;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    ingredientDao = IngredientDao(database);

    IngredientTypeDao ingredientTypeDao = IngredientTypeDao(database);
    await ingredientTypeDao
        .insertIngredientType(IngredientTypesCompanion(name: Value("type")));
  });

  tearDown(() async {
    await database.close();
  });

  test('ingredient name has a unique constraint', () async {
    await ingredientDao.insertIngredient(IngredientsCompanion(
        name: Value("NAME"), ingredientType: Value("type")));

    expect(
        () async => await ingredientDao.insertIngredient(IngredientsCompanion(
            name: Value("NAME"), ingredientType: Value("type"))),
        throwsA(isA<SqliteException>().having((e) => e.message, "message",
            contains("UNIQUE constraint failed"))));
  });

  test('fetchAllIngredients returns all ingredient s', () async {
    expect((await ingredientDao.fetchAllIngredients()).length, 0);

    await ingredientDao.insertIngredient(IngredientsCompanion(
        name: Value("NAME"), ingredientType: Value("type")));

    expect((await ingredientDao.fetchAllIngredients()).length, 1);
  });

  test('insertIngredient adds a new ingredient ', () async {
    await ingredientDao.insertIngredient(IngredientsCompanion(
        name: Value("NAME"), ingredientType: Value("type")));

    List<String> s = await ingredientDao.fetchAllIngredients();

    print(s);

    expect(s.contains("NAME"), true);
  });

  test('deleteIngredient removes a ingredient ', () async {
    await ingredientDao.insertIngredient(
      IngredientsCompanion(name: Value("NAME"), ingredientType: Value("type")),
    );

    List<String> s = await ingredientDao.fetchAllIngredients();

    print(s);

    await ingredientDao.deleteIngredient(
      IngredientsCompanion(name: Value("NAME"), ingredientType: Value("type")),
    );

    s = await ingredientDao.fetchAllIngredients();

    expect(!s.contains("NAME"), true);
  });
}
