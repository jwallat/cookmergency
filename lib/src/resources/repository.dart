import "dart:async";
import "../models/recipe_model.dart";
import "../resources/remote_recipe_provider.dart";

class Repository {
  /// Handle item fetching and saving

  /// should be returning future from db
  List<String> fetchIngredients() {
    fetchIngredientTypes();
    return <String>["Eier", "Mehl", "Milch", "Nutella"];
  }

  Future<List<String>> fetchIngredientTypes() {
    /// achtung!!!!!
    return null; //remoteRecipeProvider.fetchRecipeTypes();
  }

  /// should be returning future from local/remote db
  List<String> getRecipeTypes() {
    return <String>["Frühstück", "Nudelgerichte", "Fisch", "Desserts"];
  }

  Future<List<String>> fetchRecipeTypes() async {
    return remoteRecipeProvider.fetchRecipeTypes();
  }
}
