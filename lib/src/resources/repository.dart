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
    return remoteRecipeProvider.fetchIngredientTypes();
  }

  /// should be returning future from local/remote db
  List<String> getRecipeTypes() {
    return <String>["Frühstück", "Nudelgerichte", "Fisch", "Desserts"];
  }
}
