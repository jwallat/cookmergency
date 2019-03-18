import "dart:async";
import "package:sqljocky5/sqljocky.dart";
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

  RemoteRecipeProvider() {
    init();
  }

  void init() async {
    print("opening connection");
    conn = await MySqlConnection.connect(s);
    print("connection open");
  }

  Future<RecipeModel> fetchRecipe(int id) async {
    final StreamedResults streamedResults =
        await conn.execute("select * from Recipes where id='$id'");

    final Results results = await streamedResults.deStream();
    if (results.isNotEmpty) {
      print(results);
    }
    return null;
  }

  Future<List<String>> fetchRecipeTypes() async {
    conn = await MySqlConnection.connect(s);
    final Results results =
        await (await conn.execute("select recipeTypeName from RecipeTypes"))
            .deStream();
    conn.close();

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
    conn.close();

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
    conn.close();

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
    String query = "";
    conn = await MySqlConnection.connect(s);
    final Results results = await (await conn.execute(query)).deStream();
    conn.close();

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
}

final RemoteRecipeProvider remoteRecipeProvider = RemoteRecipeProvider();
