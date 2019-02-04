class Repository {
  /// Handle item fetching and saving

  /// should be returning future from db
  List<String> getIngredients() {
    return <String>["Eier", "Mehl", "Milch", "Nutella"];
  }

  /// should be returning future from local/remote db
  List<String> getRecipeTypes() {
    return <String>["Frühstück", "Nudelgerichte", "Fisch", "Desserts"];
  }
}
