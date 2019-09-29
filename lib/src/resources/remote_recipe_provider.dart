import "dart:async";
import 'dart:math';
//import "package:sqljocky5/sqljocky.dart";
import 'package:cookmergency/src/resources/abstract_recipe_provider.dart';
import "package:mysql1/mysql1.dart";
import "../models/ingredient_model.dart";
import "../models/recipe_model.dart";

class RemoteRecipeProvider extends AbstractRecipeProvider {
  final ConnectionSettings s = ConnectionSettings(
    user: "cookmergency",
    password: "cookmergency",
    host: "swizzlepi.ddns.net",
    port: 3306,
    db: "cookmergency",
  );
  MySqlConnection conn;

  RemoteRecipeProvider();

  Future<bool> isAvailable() async {
    conn = await MySqlConnection.connect(s);
    final Results results = await conn.query("SELECT 1");

    return results.isEmpty ? false : true;
  }

  Future<void> initConnection() async {
    print("peter");
    conn = await MySqlConnection.connect(s);
  }

  Future<RecipeModel> fetchRecipe(int id) async {
    conn = conn ?? await MySqlConnection.connect(s);
    final Results results = await conn.query(
        "SELECT * FROM IngredientAmounts ia JOIN Recipes r ON (ia.recipeTitle = r.recipeTitle) WHERE r.id='$id'");
    //await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");

      return RecipeModel.fromDb(results);
    }

    return null;
  }

  Future<List<String>> fetchRecipeTypes() async {
    conn = conn ?? await MySqlConnection.connect(s);
    final Results results =
        await conn.query("select recipeTypeName from RecipeTypes");
    //await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");
      final List<String> recipeTypes = <String>[];
      for (Row r in results) {
        recipeTypes.add(r[0]);
      }
      return recipeTypes;
    }
    return null;
  }

  Future<List<String>> fetchIngredientTypes() async {
    conn = conn ?? await MySqlConnection.connect(s);
    final Results results =
        await conn.query("select ingredientTypeName from IngredientTypes");
    //await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");
      final List<String> ingredientTypes = <String>[];
      for (Row r in results) {
        ingredientTypes.add(r[0]);
      }
      return ingredientTypes;
    }
    return null;
  }

  Future<List<String>> fetchIngredients() async {
    conn = conn ?? await MySqlConnection.connect(s);
    final Results results =
        await conn.query("select ingredientName from Ingredients");
    //await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");
      final List<String> ingredients = <String>[];
      for (Row r in results) {
        ingredients.add(r[0]);
      }
      return ingredients;
    }
    return null;
  }

  Future<List<int>> fetchRecipeIds(
      List<String> chosenRecipeTypes, List<String> chosenIngredients) async {
    String recipeTypes = "";
    for (String recipeType in chosenRecipeTypes) {
      recipeTypes += "'$recipeType',";
    }

    String ingredients = "";
    for (String ingredient in chosenIngredients) {
      ingredients += "'$ingredient',";
    }
    if (recipeTypes.isNotEmpty && ingredients.isNotEmpty) {
      recipeTypes = recipeTypes.substring(0, recipeTypes.length - 1) ?? "";
      ingredients = ingredients.substring(0, ingredients.length - 1) ?? "";
    }

    String query;
    if (ingredients.isEmpty && recipeTypes.isEmpty) {
      //TODO: Entscheiden wann alle und wann nur manche gezeigt werden sollen
      query = "SELECT DISTINCT r.id FROM Recipes r";
    } else if (recipeTypes.isEmpty && ingredients.isNotEmpty) {
      query = "SELECT DISTINCT r.id FROM Recipes r";
    } else if (recipeTypes.isNotEmpty && ingredients.isEmpty) {
      query = "SELECT DISTINCT r.id FROM Recipes r";
    } else {
      query = "SELECT DISTINCT r.id FROM IngredientAmounts ia "
          "JOIN Recipes r ON (ia.recipeTitle = r.recipeTitle) WHERE r.recipeTypeName IN ($recipeTypes)"
          "AND ia.recipeTitle NOT IN "
          "("
          "SELECT ib.recipeTitle "
          "FROM IngredientAmounts ib "
          "WHERE ib.ingredientName NOT IN ($ingredients)"
          ")";
    }
    //print(query);
    conn = conn ?? await MySqlConnection.connect(s);
    final Results results = await conn.query(query);
    //await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");
      final List<int> recipeIds = <int>[];
      for (Row r in results) {
        recipeIds.add(r[0]);
      }
      return recipeIds;
    }
    return null;
  }

  Future<bool> addRecipeType(String recipeType) async {
    if (await containsRecipeType(recipeType)) {
      return true;
    }

    final int id = Random().nextInt(1000000);
    conn = conn ?? await MySqlConnection.connect(s);
    try {
      await conn.query(
          "INSERT INTO RecipeTypes (id, recipeTypeName) VALUES ('$id', '$recipeType')");
      //await conn.close();

      return true;
    } catch (e) {
      print("Exception " + e.toString());
    }

    return false;
  }

  Future<bool> addRecipe(RecipeModel recipe) async {
    String title = recipe.title;
    String recipeType = recipe.type;
    String preperationText = recipe.preparationText;
    String imageUrl = recipe.imgUrl;

    if (await containsRecipeTitle(title)) {
      print("Title already exists");
      return false;
    }

    final int id = Random().nextInt(1000000);
    try {
      conn = conn ?? await MySqlConnection.connect(s);
      await conn.query(
          "INSERT INTO Recipes (id, recipeTypeName, recipeTitle, preparationText, imageURL) VALUES "
          "('$id', '$recipeType', '$title', '$preperationText', '$imageUrl')");
      //await conn.close();
      return true;
    } catch (e) {
      print("Exception " + e);
    }

    return false;
  }

  Future<bool> addIngredient(String name) async {
    final int id = Random().nextInt(1000000);

    if (await containsIngredient(name)) {
      return true;
    }

    try {
      conn = conn ?? await MySqlConnection.connect(s);
      await conn.query(
          "INSERT INTO Ingredients (id, ingredientTypeName, ingredientName) VALUES ('$id', 'Diverses', '$name')");
      //await conn.close();

      return true;
    } catch (e) {
      print("Exception " + e.toString());
    }

    return false;
  }

  Future<bool> addIngredientAmountModel(IngredientAmountModel model) async {
    final int id = Random().nextInt(1000000);
    try {
      conn = conn ?? await MySqlConnection.connect(s);
      await conn.query(
          "INSERT INTO `IngredientAmounts` (`id`, `ingredientName`, `recipeTitle`, `amount`, `amountUnit`) VALUES "
          "('$id', '${model.ingredientName}', '${model.recipeTitle}', '${model.amount}', '${model.unit}')");
      //await conn.close();

      return true;
    } catch (e) {
      print("Exception " + e.toString());
    }

    return false;
  }

  Future<bool> containsRecipeTitle(String recipeTitle) async {
    conn = conn ?? await MySqlConnection.connect(s);
    final Results results = await conn
        .query("SELECT * FROM Recipes WHERE recipeTitle='$recipeTitle'");
    //await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");

      return true;
    }
    return false;
  }

  Future<bool> containsIngredient(String ingredientName) async {
    if ((await fetchIngredients()).contains(ingredientName)) {
      return true;
    }
    return false;
  }

  Future<bool> containsRecipeType(String recipeType) async {
    if ((await fetchRecipeTypes()).contains(recipeType)) {
      return true;
    }
    return false;
  }
}

// final AbstractRecipeProvider remoteRecipeProvider = RemoteRecipeProvider();
