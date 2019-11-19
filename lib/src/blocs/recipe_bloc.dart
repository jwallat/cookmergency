import "dart:async";
import 'package:cookmergency/src/models/recipe_id_model.dart';
import "package:rxdart/rxdart.dart";
import 'package:tuple/tuple.dart';
import "../models/recipe_model.dart";
import "../resources/repository.dart";

class RecipeBloc {
  final Repository repository = Repository();

  final PublishSubject<RecipeIdModel> _recipeFetcher =
      PublishSubject<RecipeIdModel>();
  final BehaviorSubject<Map<RecipeIdModel, Future<RecipeModel>>> _recipeOutput =
      BehaviorSubject<Map<RecipeIdModel, Future<RecipeModel>>>();

  final BehaviorSubject<List<RecipeIdModel>> _recipeIds =
      BehaviorSubject<List<RecipeIdModel>>();
  final ReplaySubject<List<String>> _recipeTypes =
      ReplaySubject<List<String>>();
  final ReplaySubject<List<String>> _ingredientTypes =
      ReplaySubject<List<String>>();
  final ReplaySubject<List<String>> _ingredients =
      ReplaySubject<List<String>>();

  final Map<String, bool> _recipeTypesMap = <String, bool>{};
  final Map<String, bool> _ingredientsMap = <String, bool>{};

  List<String> recipeTypesList = <String>[];
  List<String> ingredientsList = <String>[];
  List<String> unitsList = <String>[];

  RecipeBloc() {
    _recipeFetcher.stream
        .transform<Map<RecipeIdModel, Future<RecipeModel>>>(
            _recipeTransformer())
        .pipe(_recipeOutput);
  }

  // Getter to the streams
  Observable<List<RecipeIdModel>> get recipeIds => _recipeIds.stream;
  Observable<Map<RecipeIdModel, Future<RecipeModel>>> get recipes =>
      _recipeOutput.stream;
  Observable<List<String>> get recipeTypes => _recipeTypes.stream;
  Observable<List<String>> get ingredientTypes => _ingredientTypes.stream;
  Observable<List<String>> get ingredients => _ingredients.stream;

  // Getter to the sinks
  Function(RecipeIdModel) get fetchRecipe => _recipeFetcher.sink.add;

  dynamic _recipeTransformer() async {
    return ScanStreamTransformer(
      (Map<RecipeIdModel, Future<RecipeModel>> cache, RecipeIdModel idModel,
          int index) {
        cache[idModel] = repository.fetchRecipe(idModel);
        return cache;
      },
      <RecipeIdModel, Future<RecipeModel>>{},
    );
  }

  dynamic fetchRecipeIds() async {
    // Filter selected ingredients
    _ingredientsMap.removeWhere((String ingredient, bool chosen) => !chosen);
    final List<String> chosenIngredients = _ingredientsMap.keys.toList();

    // Filter selected recipeTypes
    _recipeTypesMap.removeWhere((String recipeType, bool chosen) => !chosen);
    final List<String> chosenRecipeTypes = _recipeTypesMap.keys.toList();

    final List<RecipeIdModel> recipeIds =
        await repository.fetchRecipeIds(chosenRecipeTypes, chosenIngredients);

    _recipeIds.add(recipeIds);
  }

  dynamic fetchRecipeTypes() async {
    final Tuple2<Future<List<String>>, Future<List<String>>> recipeTypes =
        repository.fetchRecipeTypes();

    // Local data
    recipeTypes.item1.then((data) => _recipeTypes.add(data));
    // Remote data
    recipeTypes.item2.then((data) => _recipeTypes.add(data));
  }

  dynamic connectRemoteDB() {
    repository.initRemoteConnection();
  }

  dynamic fetchIngredientTypes() async {
    final Tuple2<Future<List<String>>, Future<List<String>>> ingredientTypes =
        repository.fetchIngredientTypes();

    // Local data
    ingredientTypes.item1.then((data) => _ingredientTypes.add(data));
    // Remote data
    ingredientTypes.item2.then((data) => _ingredientTypes.add(data));
  }

  dynamic fetchIngredients() async {
    final Tuple2<Future<List<String>>, Future<List<String>>> ingredients =
        repository.fetchIngredients();

    // Local data
    ingredients.item1.then((data) => _ingredients.add(data));
    // Remote data
    ingredients.item2.then((data) => _ingredients.add(data));
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
