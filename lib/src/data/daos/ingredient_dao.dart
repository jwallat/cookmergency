import 'package:cookmergency/src/data/tables/ingredients.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../moor_database.dart';

part 'ingredient_dao.g.dart';

@UseDao(tables: [Ingredients])
class IngredientDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientDaoMixin {
  final AppDatabase db;

  IngredientDao(this.db) : super(db);

  Future<List<Ingredient>> getAllIngredients() => select(ingredients).get();
  Future insertIngredient(Insertable<Ingredient> ingredient) =>
      into(ingredients).insert(ingredient);
  Future updateIngredient(Insertable<Ingredient> ingredient) =>
      update(ingredients).replace(ingredient);
  Future deleteIngredient(Insertable<Ingredient> ingredient) =>
      delete(ingredients).delete(ingredient);
}
