import "dart:async";
import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:cookmergency/src/resources/abstract_recipe_provider.dart';
import "../models/recipe_model.dart";

class LocalRecipeProvider implements AbstractRecipeProvider {
  final db = AppDatabase();
  RecipeDao recipeDao;
  RecipeTypeDao recipeTypeDao;
  IngredientDao ingredientDao;
  IngredientTypeDao ingredientTypeDao;
  IngredientAmountDao ingredientAmountDao;

  LocalRecipeProvider() {
    this.recipeDao = db.recipeDao;
    this.recipeTypeDao = db.recipeTypeDao;
    this.ingredientDao = db.ingredientDao;
    this.ingredientTypeDao = db.ingredientTypeDao;
    this.ingredientAmountDao = db.ingredientAmountDao;
  }

  Future<RecipeModel> fetchRecipe(int id) async {
    return recipeDao.fetchRecipe(id);
  }

  Future<List<String>> fetchRecipeTypes() async {
    return recipeTypeDao.fetchAllRecipeTypes();
  }

  Future<List<String>> fetchIngredientTypes() async {
    return ingredientTypeDao.fetchAllIngredientTypes();
  }

  Future<List<String>> fetchIngredients() async {
    return ingredientDao.fetchAllIngredients();
  }

  Future<List<int>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    return recipeDao.getRecipeIds(chosenRecipeTypes, chosenIngredients);
  }

  Future<bool> addRecipeType(String recipeType) async {
    return false;
  }

  Future<bool> addRecipe(RecipeModel recipe) async {
    //handle with care and do transaction in correct order
    return false;
  }
}
