import "../resources/repository.dart";

class RecipeBloc {
  final Repository repository = Repository();
  final Map<String, bool> _recipeTypes = <String, bool>{};
  final Map<String, bool> _ingredients = <String, bool>{};

  /// should use streams and return items that way
  // TODO(jw): call load functions from somewhere
  void loadIngredients() {
    if (_ingredients.isEmpty) {
      for (String ingredient in repository.fetchIngredients()) {
        _ingredients[ingredient] = false;
      }
    }
  }

  void fetchIngredientTypes() {}

  Map<String, bool> getIngredients() {
    return _ingredients;
  }

  /// Loads the recipe types from the repository
  void loadRecipeTypes() {
    if (_recipeTypes.isEmpty) {
      for (String recipeType in repository.getRecipeTypes()) {
        _recipeTypes[recipeType] = false;
      }
    }
  }

  Map<String, bool> getRecipeTypes() {
    return _recipeTypes;
  }

  bool isSelectedRecipeType(String recipeType) {
    return _recipeTypes[recipeType];
  }

  void setSelectedRecipeType(String recipeType, bool value) {
    _recipeTypes[recipeType] = value;
  }

  bool isSelectedIngredient(String ingredient) {
    return _ingredients[ingredient];
  }

  void setSelectedIngredient(String ingredient, bool value) {
    _ingredients[ingredient] = value;
  }
}
