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

  List<String> recipeTypesList = <String>[];

  RecipeBloc() {
    _recipeFetcher.stream
        .transform<Map<int, Future<RecipeModel>>>(_recipeTransformer())
        .pipe(_recipeOutput);
  }

  // Getter to the streams
  Observable<List<int>> get recipeIds => _recipeIds.stream;
  Observable<Map<int, Future<RecipeModel>>> get recipes => _recipeOutput.stream;
  Observable<List<String>> get recipeTypes => _recipeTypes.stream;
  Observable<List<String>> get ingredientTypes => _ingredientTypes.stream;
  Observable<List<String>> get ingredients => _ingredients.stream;

  // Getter to the sinks
  Function(int) get fetchRecipe => _recipeFetcher.sink.add;

  dynamic _recipeTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<RecipeModel>> cache, int id, int index) {
        cache[id] = repository.fetchRecipe(id);
        return cache;
      },
      <int, Future<RecipeModel>>{},
    );
  }

  dynamic fetchRecipeIds() async {
    // Filter selected ingredients
    _ingredientsMap.removeWhere((String ingredient, bool chosen) => !chosen);
    final List<String> chosenIngredients = _ingredientsMap.keys.toList();

    // Filter selected recipeTypes
    _recipeTypesMap.removeWhere((String recipeType, bool chosen) => !chosen);
    final List<String> chosenRecipeTypes = _recipeTypesMap.keys.toList();

    final List<int> recipeIds =
        await repository.fetchRecipeIds(chosenRecipeTypes, chosenIngredients);

    _recipeIds.add(recipeIds);
  }

  dynamic fetchRecipeTypes() async {
    recipeTypesList = await repository.fetchRecipeTypes();

    _recipeTypes.add(recipeTypesList);
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

  Map<String, bool> getRecipeTypesMap() {
    return _recipeTypesMap;
  }

  void setSelectedIngredient(String ingredient, bool value) {
    _ingredientsMap[ingredient] = value;
  }

  void dispose() {
    _recipeTypes.close();
    _ingredientTypes.close();
    _ingredients.close();
    _recipeFetcher.close();
    _recipeOutput.close();
  }
}
