import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:moor_ffi/database.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase database;
  IngredientTypeDao ingredientTypeDao;

  setUp(() async {
    database = AppDatabase(VmDatabase.memory());
    ingredientTypeDao = IngredientTypeDao(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('ingredientType name has a unique constraint', () async {
    await ingredientTypeDao
        .insertIngredientType(IngredientTypesCompanion(name: Value("NAME")));

    expect(
        () async => await ingredientTypeDao.insertIngredientType(
            IngredientTypesCompanion(name: Value("NAME"))),
        throwsA(isA<SqliteException>().having((e) => e.message, "message",
            contains("UNIQUE constraint failed"))));
  });

  test('fetchAllIngredientTypes returns all ingredient types', () async {
    expect((await ingredientTypeDao.fetchAllIngredientTypes()).length, 0);

    await ingredientTypeDao
        .insertIngredientType(IngredientTypesCompanion(name: Value("NAME")));

    expect((await ingredientTypeDao.fetchAllIngredientTypes()).length, 1);
  });

  test('insertIngredientType adds a new ingredient type', () async {
    await ingredientTypeDao
        .insertIngredientType(IngredientTypesCompanion(name: Value("NAME")));

    List<String> types = await ingredientTypeDao.fetchAllIngredientTypes();

    print(types);

    expect(types.contains("NAME"), true);
  });

  test('deleteIngredientType removes a ingredient type', () async {
    await ingredientTypeDao.insertIngredientType(
      IngredientTypesCompanion(
        name: Value("NAME"),
      ),
    );

    List<String> types = await ingredientTypeDao.fetchAllIngredientTypes();

    print(types);

    await ingredientTypeDao.deleteIngredientType(
      IngredientTypesCompanion(
        name: Value("NAME"),
      ),
    );

    types = await ingredientTypeDao.fetchAllIngredientTypes();

    expect(!types.contains("NAME"), true);
  });
}
