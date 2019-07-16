import "dart:async";
import 'dart:math';
import "package:sqljocky5/sqljocky.dart";
import "../models/ingredient_model.dart";
import "../models/recipe_model.dart";

class RemoteRecipeProvider {
  final ConnectionSettings s = ConnectionSettings(
    user: "cookmergency",
    password: "cookmergency",
    host: "swizzlepi.ddns.net",
    port: 3306,
    db: "cookmergency",
  );
  MySqlConnection conn;

  RemoteRecipeProvider();

  Future<RecipeModel> fetchRecipe(int id) async {
    conn = await MySqlConnection.connect(s);
    final Results results = await (await conn.execute(
            "SELECT * FROM IngredientAmounts ia JOIN Recipes r ON (ia.recipeTitle = r.recipeTitle) WHERE r.id='$id'"))
        .deStream();
    await conn.close();

    if (results.isNotEmpty) {
      //print("DB responded with $results");

      return RecipeModel.fromDb(results);
    }

    return null;
  }

  Future<List<String>> fetchRecipeTypes() async {
    conn = await MySqlConnection.connect(s);
    final Results results =
        await (await conn.execute("select recipeTypeName from RecipeTypes"))
            .deStream();
    await conn.close();

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
    conn = await MySqlConnection.connect(s);
    final Results results = await (await conn
            .execute("select ingredientTypeName from IngredientTypes"))
        .deStream();
    await conn.close();

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
    conn = await MySqlConnection.connect(s);
    final Results results =
        await (await conn.execute("select ingredientName from Ingredients"))
            .deStream();
    await conn.close();

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
    conn = await MySqlConnection.connect(s);
    final Results results = await (await conn.execute(query)).deStream();
    await conn.close();

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
    final int id = Random().nextInt(1000000);
    conn = await MySqlConnection.connect(s);
    try {
      final Results results = await (await conn.execute(
              "INSERT INTO RecipeTypes (id, recipeTypeName) VALUES ('$id', '$recipeType')"))
          .deStream();
      await conn.close();

      if (results.isNotEmpty) {
        print("DB responded with $results");

        return true;
      }
    } catch (e) {
      print("Exception " + e.toString());
    }

    return false;
  }

  Future<bool> addRecipeToDB(String title, String recipeType,
      String preperationText, String imageURL) async {
    final int id = Random().nextInt(1000000);
    try {
      conn = await MySqlConnection.connect(s);
      final Results results = await (await conn.execute(
              "INSERT INTO Recipes (id, recipeTypeName, recipeTitle, preparationText, imageURL) VALUES "
              "('$id', '$recipeType', '$title', '$preperationText', '$imageURL')"))
          .deStream();
      await conn.close();

      if (results.isNotEmpty) {
        print("DB responded with $results");

        return true;
      }
    } catch (e) {
      print("Exception " + e);
    }

    return false;
  }

  Future<bool> addIngredient(String name) async {
    final int id = Random().nextInt(1000000);

    try {
      conn = await MySqlConnection.connect(s);
      final Results results = await (await conn.execute(
              "INSERT INTO Ingredients (id, ingredientTypeName, ingredientName) VALUES ('$id', 'Diverses', '$name')"))
          .deStream();
      await conn.close();

      if (results.isNotEmpty) {
        print("DB responded with $results");

        return true;
      }
    } catch (e) {
      print("Exception " + e.toString());
    }

    return false;
  }

  Future<bool> addIngredientAmountModel(IngredientAmountModel model) async {
    final int id = Random().nextInt(1000000);
    try {
      conn = await MySqlConnection.connect(s);
      final Results results = await (await conn.execute(
              "INSERT INTO `IngredientAmounts` (`id`, `ingredientName`, `recipeTitle`, `amount`, `amountUnit`) VALUES "
              "('$id', '${model.ingredientName}', '${model.recipeTitle}', '${model.amount}', '${model.unit}')"))
          .deStream();
      await conn.close();

      if (results.isNotEmpty) {
        print("DB responded with $results");

        return true;
      }
    } catch (e) {
      print("Exception " + e.toString());
    }

    return false;
  }
}

final RemoteRecipeProvider remoteRecipeProvider = RemoteRecipeProvider();
