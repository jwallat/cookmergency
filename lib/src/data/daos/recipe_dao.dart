import 'package:cookmergency/src/data/tables/recipes.dart';
import 'package:moor_flutter/moor_flutter.dart';
import '../moor_database.dart';

part 'recipe_dao.g.dart';

@UseDao(tables: [Recipes])
class RecipeDao extends DatabaseAccessor<AppDatabase> with _$RecipeDaoMixin {
  final AppDatabase db;

  RecipeDao(this.db) : super(db);
}
