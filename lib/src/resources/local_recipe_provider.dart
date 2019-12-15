import "dart:async";
import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_ids_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:cookmergency/src/models/ingredient_model.dart';
import 'package:cookmergency/src/models/recipe_id_model.dart';
import 'package:moor_flutter/moor_flutter.dart';
import "../models/recipe_model.dart";

class LocalRecipeProvider {
  final db = AppDatabase(
    FlutterQueryExecutor.inDatabaseFolder(
        path: "db.sqlite", logStatements: false),
  );
  RecipeDao recipeDao;
  RecipeIdDao recipeIdDao;
  RecipeTypeDao recipeTypeDao;
  IngredientDao ingredientDao;
  IngredientTypeDao ingredientTypeDao;
  IngredientAmountDao ingredientAmountDao;

  LocalRecipeProvider() {
    this.recipeDao = db.recipeDao;
    this.recipeIdDao = db.recipeIdDao;
    this.recipeTypeDao = db.recipeTypeDao;
    this.ingredientDao = db.ingredientDao;
    this.ingredientTypeDao = db.ingredientTypeDao;
    this.ingredientAmountDao = db.ingredientAmountDao;
  }

  LocalRecipeProvider.fromDaos({
    this.recipeDao,
    this.recipeIdDao,
    this.recipeTypeDao,
    this.ingredientDao,
    this.ingredientTypeDao,
    this.ingredientAmountDao,
  });

  Future<RecipeModel> fetchRecipe(int id) async {
    Recipe recipe = await recipeDao.fetchRecipe(id);
    List<IngredientAmount> ias = await ingredientAmountDao
        .getAllIngredientAmountsForRecipe(recipe.title);
    List<IngredientAmountModel> iaModels = List();
    for (IngredientAmount ia in ias) {
      iaModels.add(IngredientAmountModel.fromLocalDB(ia));
    }

    return RecipeModel.fromLocalDb(recipe, iaModels);
  }

  Future<List<String>> fetchRecipeTypes() async {
    List<String> recipeTypeNames = List();
    (await recipeTypeDao.fetchAllRecipeTypes())
        .forEach((RecipeType r) => recipeTypeNames.add(r.name));

    return recipeTypeNames;
  }

  Future<List<String>> fetchIngredientTypes() async {
    return ingredientTypeDao.fetchAllIngredientTypes();
  }

  Future<List<String>> fetchIngredients() async {
    return ingredientDao.fetchAllIngredients();
  }

  Future<List<RecipeIdModel>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    List<int> localIds =
        await recipeDao.fetchRecipeIds(chosenRecipeTypes, chosenIngredients);

    List<RecipeIdModel> ids = List();
    localIds
        .forEach((int id) => ids.add(RecipeIdModel.fromLocalId(localId: id)));

    return ids;
  }

  // bool importRemoteIds(List<int> remoteIds) {
  //   try {
  //     for (int remoteId in remoteIds) {
  //       recipeIdDao.insertRemoteId(RecipeIdsCompanion(
  //         remoteId: Value(remoteId),
  //       ));
  //     }
  //   } catch (Exception) {
  //     print('Error occured importing RemoteIds into local Db');
  //     return false;
  //   }

  //   return true;
  // }

  // Future<bool> addRecipeType(String recipeType) async {
  //   return false;
  // }

  Future<bool> addRecipe(RecipeModel recipe) async {
    recipeTypeDao.insertRecipeType(RecipeTypesCompanion(
      name: Value(recipe.type),
    ));

    recipeDao.insertRecipe(RecipesCompanion(
      title: Value(recipe.title),
      recipeType: Value(recipe.type),
      imageUrl: Value(recipe.imgUrl),
      preparationText: Value(recipe.preparationText),
      preparationTime: Value(recipe.preparationTimeInMinutes.toString()),
    ));

    for (IngredientAmountModel ingredientAmount in recipe.ingredients) {
      ingredientTypeDao.insertIngredientType(IngredientTypesCompanion(
        name: Value("<<placeholder>>"),
      ));

      ingredientDao.insertIngredient(IngredientsCompanion(
        name: Value(ingredientAmount.ingredientName),
        ingredientType: Value("<<placeholder>>"),
      ));

      ingredientAmountDao.insertIngredientAmount(IngredientAmountsCompanion(
        recipeTitle: Value(recipe.title),
        ingredientName: Value(ingredientAmount.ingredientName),
        amount: Value(int.parse(ingredientAmount.amount)),
        amountUnit: Value(ingredientAmount.unit),
      ));
    }

    return true;
  }
}
