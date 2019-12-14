import 'package:cookmergency/src/data/tables/ingredientAmounts.dart';
import 'package:moor/moor.dart';
import '../moor_database.dart';

part 'ingredient_amount_dao.g.dart';

@UseDao(tables: [IngredientAmounts])
class IngredientAmountDao extends DatabaseAccessor<AppDatabase>
    with _$IngredientAmountDaoMixin {
  final AppDatabase db;

  IngredientAmountDao(this.db) : super(db);

  Future<List<IngredientAmount>> getAllIngredientAmountsForRecipe(
          String recipeTitle) =>
      (select(ingredientAmounts)
            ..where((ia) => ia.recipeTitle.equals(recipeTitle)))
          .get();
  Future insertIngredientAmount(
          Insertable<IngredientAmount> ingredientAmount) =>
      into(ingredientAmounts).insert(ingredientAmount);
  Future deleteRecipeType(Insertable<IngredientAmount> ingredientAmount) =>
      delete(ingredientAmounts).delete(ingredientAmount);
}
