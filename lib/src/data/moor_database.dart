import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/tables/ingredientAmounts.dart';
import 'package:cookmergency/src/data/tables/ingredientTypes.dart';
import 'package:cookmergency/src/data/tables/ingredients.dart';
import 'package:cookmergency/src/data/tables/recipeTypes.dart';
import 'package:cookmergency/src/data/tables/recipes.dart';
import 'package:moor_flutter/moor_flutter.dart';

part "moor_database.g.dart";

@UseMoor(tables: [
  Recipes,
  Ingredients,
  IngredientTypes,
  RecipeTypes,
  IngredientAmounts
], daos: [
  RecipeDao,
  IngredientDao,
  IngredientTypeDao,
  RecipeTypeDao,
  IngredientAmountDao
])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
              path: "db.sqlite", logStatements: false),
        );

  @override
  int get schemaVersion => 1;
}
