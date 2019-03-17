import "package:rxdart/rxdart.dart";
import "../resources/repository.dart";

class RecipeBloc {
  final Repository repository = Repository();

  final ReplaySubject<List<String>> _recipeTypes =
      ReplaySubject<List<String>>();

  final Map<String, bool> _recipeTypesMap = <String, bool>{};
  final Map<String, bool> _ingredients = <String, bool>{};

  final PublishSubject<int> _recipeFetcher = PublishSubject<int>();

  // Getter to the streams
  Observable<List<String>> get recipeTypes => _recipeTypes.stream;

  dynamic fetchRecipeTypes() async {
    final List<String> recipeTypes = await repository.fetchRecipeTypes();
    // for (String s in recipeTypes) {
    //   _recipeTypesMap.putIfAbsent(s, () {
    //     return false;
    //   });
    // }
    _recipeTypes.add(recipeTypes);
  }

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
    if (_recipeTypesMap.isEmpty) {
      for (String recipeType in repository.getRecipeTypes()) {
        _recipeTypesMap[recipeType] = false;
      }
    }
  }

  Function(int) get fetchRecipe => _recipeFetcher.sink.add;

  @Deprecated("to be retired for fetchRecipeTypes()")
  Map<String, bool> getRecipeTypes() {
    return _recipeTypesMap;
  }

  bool isSelectedRecipeType(String recipeType) {
    return _recipeTypesMap[recipeType];
  }

  void setSelectedRecipeType(String recipeType, bool value) {
    _recipeTypesMap[recipeType] = value;
  }

  bool isSelectedIngredient(String ingredient) {
    return _ingredients[ingredient];
  }

  void setSelectedIngredient(String ingredient, bool value) {
    _ingredients[ingredient] = value;
  }

  void dispose() {
    _recipeTypes.close();
    _recipeFetcher.close();
  }
}
