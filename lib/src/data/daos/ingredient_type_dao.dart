import 'package:cookmergency/src/data/tables/ingredientTypes.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../moor_database.dart';

part 'ingredient_type_dao.g.dart';

@UseDao(tables: [IngredientTypes])
class IngredientTypeDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientTypeDaoMixin {
  final AppDatabase db;

  IngredientTypeDao(this.db) : super(db);

  Future<List<String>> fetchAllIngredientTypes() =>
      select(ingredientTypes).get().then((rows) => List.from(rows));
  Future insertIngredientType(Insertable<IngredientType> ingredientType) =>
      into(ingredientTypes).insert(ingredientType);
  Future deleteIngredientType(Insertable<IngredientType> ingredientType) =>
      delete(ingredientTypes).delete(ingredientType);
}
