import 'package:cookmergency/src/data/tables/recipeTypes.dart';
import 'package:moor/moor.dart';
import '../moor_database.dart';

part 'recipe_type_dao.g.dart';

@UseDao(tables: [RecipeTypes])
class RecipeTypeDao extends DatabaseAccessor<AppDatabase>
    with _$RecipeTypeDaoMixin {
  final AppDatabase db;

  RecipeTypeDao(this.db) : super(db);

  Future<List<RecipeType>> fetchAllRecipeTypes() => select(recipeTypes).get();
  Future insertRecipeType(Insertable<RecipeType> recipeType) =>
      into(recipeTypes).insert(recipeType);
  Future deleteRecipeType(Insertable<RecipeType> recipeType) =>
      delete(recipeTypes).delete(recipeType);
}
