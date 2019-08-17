import 'package:cookmergency/src/data/ingredientAmounts.dart';
import 'package:cookmergency/src/data/ingredientTypes.dart';
import 'package:cookmergency/src/data/ingredients.dart';
import 'package:cookmergency/src/data/recipeTypes.dart';
import 'package:cookmergency/src/data/recipes.dart';
import 'package:moor_flutter/moor_flutter.dart';

@UseMoor(tables: [Receipes, Ingredients, IngredientTypes, RecipeTypes, IngredientAmounts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super();

}