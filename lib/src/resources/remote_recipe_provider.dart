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

  Future<List<String>> fetchIngredientTypes() async {
    conn = await MySqlConnection.connect(s);
    final Results results = await (await conn
            .execute("select ingredientTypeName from IngredientTypes"))
        .deStream();
    conn.close();

    var list = results.toList();
    var l = list[0];
    print(l); // row
    print(l[0]); // string

    // if (results.isNotEmpty) {
    //   print(results);
    //   return results.toList() as FutureOr<List<String>>;
    // }
    return null;
  }

  Future<List<String>> fetchRecipeTypes() async {
    conn = await MySqlConnection.connect(s);
    final StreamedResults results =
        await conn.execute("select recipeTypeName from RecipeTypes");
    conn.close();

    print(results);
    // 'if (results.isNotEmpty) {
    //   print(results);
    // }'
    return null;
  }

  void closeConnection() async {
    await conn.close();
    print("connection closed");
  }
}

final RemoteRecipeProvider remoteRecipeProvider = RemoteRecipeProvider();
