import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_ids_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/tables/ingredientAmounts.dart';
import 'package:cookmergency/src/data/tables/ingredientTypes.dart';
import 'package:cookmergency/src/data/tables/ingredients.dart';
import 'package:cookmergency/src/data/tables/recipeTypes.dart';
import 'package:cookmergency/src/data/tables/recipes.dart';
import 'package:cookmergency/src/data/tables/recipeIds.dart';
import 'package:moor/moor.dart';

part "moor_database.g.dart";

@UseMoor(
  tables: [
    Recipes,
    RecipeIds,
    Ingredients,
    IngredientTypes,
    RecipeTypes,
    IngredientAmounts
  ],
  daos: [
    RecipeDao,
    RecipeIdDao,
    IngredientDao,
    IngredientTypeDao,
    RecipeTypeDao,
    IngredientAmountDao
  ],
)
class AppDatabase extends _$AppDatabase {
  // AppDatabase()
  //     : super(
  //         FlutterQueryExecutor.inDatabaseFolder(
  //             path: "db.sqlite", logStatements: false),
  //       );

  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (db) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
