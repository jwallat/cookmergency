import "dart:async";
import "package:rxdart/rxdart.dart";
import "../models/recipe_model.dart";
import "../resources/repository.dart";

class RecipeBloc {
  final Repository repository = Repository();

  final PublishSubject<int> _recipeFetcher = PublishSubject<int>();
  final BehaviorSubject<Map<int, Future<RecipeModel>>> _recipeOutput =
      BehaviorSubject<Map<int, Future<RecipeModel>>>();

  final BehaviorSubject<List<int>> _recipeIds = BehaviorSubject<List<int>>();
  final ReplaySubject<List<String>> _recipeTypes =
      ReplaySubject<List<String>>();
  final ReplaySubject<List<String>> _ingredientTypes =
      ReplaySubject<List<String>>();
  final ReplaySubject<List<String>> _ingredients =
      ReplaySubject<List<String>>();

  final Map<String, bool> _recipeTypesMap = <String, bool>{};
  final Map<String, bool> _ingredientsMap = <String, bool>{};

  // Getter to the streams
  Observable<List<String>> get recipeTypes => _recipeTypes.stream;
  Observable<List<String>> get ingredientTypes => _ingredientTypes.stream;
  Observable<List<String>> get ingredients => _ingredients.stream;

  // Getter to the sinks
  Function(int) get fetchRecipe => _recipeFetcher.sink.add;

  dynamic fetchRecipeIds() async {
    // Filter selected ingredients
    _ingredientsMap.removeWhere((String ingredient, bool chosen) => !chosen);
    List<String> chosenIngredients = _ingredientsMap.keys;

    // Filter selected recipeTypes
    _recipeTypesMap.removeWhere((String recipeType, bool chosen) => !chosen);
    List<String> chosenRecipeTypes = _recipeTypesMap.keys;

    final List<int> recipeIds =
        await repository.fetchRecipeIds(chosenRecipeTypes, chosenIngredients);

    _recipeIds.add(recipeIds);
  }

  dynamic fetchRecipeTypes() async {
    final List<String> recipeTypes = await repository.fetchRecipeTypes();

    _recipeTypes.add(recipeTypes);
  }

  dynamic fetchIngredientTypes() async {
    final List<String> ingredientTypes =
        await repository.fetchIngredientTypes();

    _ingredientTypes.add(ingredientTypes);
  }

  dynamic fetchIngredients() async {
    final List<String> ingredients = await repository.fetchIngredients();

    _ingredients.add(ingredients);
  }

  void setSelectedRecipeType(String recipeType, bool value) {
    _recipeTypesMap[recipeType] = value;
  }

  bool isSelectedIngredient(String ingredient) {
    return _ingredientsMap[ingredient];
  }

  Map<String, bool> getIngredientsMap() {
    return _ingredientsMap;
  }

  void setSelectedIngredient(String ingredient, bool value) {
    _ingredientsMap[ingredient] = value;
    print("[map] changed $ingredient to $value");
  }

  void dispose() {
    _recipeTypes.close();
    _ingredientTypes.close();
    _ingredients.close();
    _recipeFetcher.close();
  }
}
