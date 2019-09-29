import 'package:cookmergency/src/data/tables/recipeTypes.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../moor_database.dart';

part 'recipe_type_dao.g.dart';

@UseDao(tables: [RecipeTypes])
class RecipeTypeDao extends DatabaseAccessor<AppDatabase>
    with _$RecipeTypeDaoMixin {
  final AppDatabase db;

  RecipeTypeDao(this.db) : super(db);

  Future<List<String>> fetchAllRecipeTypes() =>
      select(recipeTypes).get().then((rows) => List.from(rows));
  Future insertRecipeType(Insertable<RecipeType> recipeType) =>
      into(recipeTypes).insert(recipeType);
  Future deleteRecipeType(Insertable<RecipeType> recipeType) =>
      delete(recipeTypes).delete(recipeType);
}
