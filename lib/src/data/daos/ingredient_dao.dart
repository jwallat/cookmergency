import 'package:cookmergency/src/data/tables/ingredients.dart';
import 'package:moor/moor.dart';
import '../moor_database.dart';

part 'ingredient_dao.g.dart';

@UseDao(tables: [Ingredients])
class IngredientDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientDaoMixin {
  final AppDatabase db;

  IngredientDao(this.db) : super(db);

  Future<List<String>> fetchAllIngredients() =>
      select(ingredients).map((ingredient) => ingredient.name).get();
  Future insertIngredient(Insertable<Ingredient> ingredient) =>
      into(ingredients).insert(ingredient);
  Future deleteIngredient(Insertable<Ingredient> ingredient) =>
      delete(ingredients).delete(ingredient);
}
