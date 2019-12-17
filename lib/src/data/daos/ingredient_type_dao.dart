import 'package:cookmergency/src/data/tables/ingredientTypes.dart';
import 'package:moor/moor.dart';
import '../moor_database.dart';

part 'ingredient_type_dao.g.dart';

@UseDao(tables: [IngredientTypes])
class IngredientTypeDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientTypeDaoMixin {
  final AppDatabase db;

  IngredientTypeDao(this.db) : super(db);

  Future<List<String>> fetchAllIngredientTypes() =>
      select(ingredientTypes).map((type) => type.name).get();
  Future insertIngredientType(Insertable<IngredientType> ingredientType) =>
      into(ingredientTypes).insert(ingredientType);
  Future deleteIngredientType(Insertable<IngredientType> ingredientType) =>
      delete(ingredientTypes).delete(ingredientType);
  Future<bool> containsIngredientType(String ingredientType) async {
    IngredientType it = await (select(ingredientTypes)
          ..where((it) => it.name.equals(ingredientType)))
        .getSingle();

    return it == null;
  }
}
