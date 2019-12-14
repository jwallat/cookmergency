import 'package:cookmergency/src/data/tables/recipeIds.dart';
import 'package:moor/moor.dart';
import '../moor_database.dart';

part 'recipe_ids_dao.g.dart';

@UseDao(tables: [RecipeIds])
class RecipeIdDao extends DatabaseAccessor<AppDatabase>
    with _$RecipeIdDaoMixin {
  final AppDatabase db;

  RecipeIdDao(this.db) : super(db);

  Future insertRemoteId(Insertable<RecipeId> recipeId) =>
      into(recipeIds).insert(recipeId);

  Future updateWithLocalId(Insertable<RecipeId> recipeId) =>
      update(recipeIds).replace(recipeId);

  Future insertLocalId(Insertable<RecipeId> recipeId) =>
      into(recipeIds).insert(recipeId);
}
