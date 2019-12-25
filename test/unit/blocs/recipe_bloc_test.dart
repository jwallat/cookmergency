import 'package:bloc_test/bloc_test.dart';
import 'package:cookmergency/src/blocs/recipe_bloc.dart';
import 'package:cookmergency/src/models/recipe_id_model.dart';
import 'package:cookmergency/src/models/recipe_model.dart';
import 'package:cookmergency/src/resources/repository.dart';
import 'package:mockito/mockito.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/test.dart';

class RecipeTypeStreamMock extends Mock implements ReplaySubject<List<String>> {
}

class IngredientTypeStreamMock extends Mock
    implements ReplaySubject<List<String>> {}

class IngredientStreamMock extends Mock implements ReplaySubject<List<String>> {
}

class RecipeIdsStreamMock extends Mock
    implements BehaviorSubject<List<RecipeIdModel>> {}

class RecipeOutputStreamMock extends Mock
    implements BehaviorSubject<Map<RecipeIdModel, Future<RecipeModel>>> {}

class RecipeFetcherStreamMock extends Mock
    implements PublishSubject<RecipeIdModel> {}

class RepositoryMock extends Mock implements Repository {}

class MockRecipeBloc extends MockBloc implements RecipeBloc {}

void main() {
  RecipeTypeStreamMock recipeTypeStreamMock = RecipeTypeStreamMock();
  IngredientTypeStreamMock ingredientTypeStreamMock =
      IngredientTypeStreamMock();
  IngredientStreamMock ingredientStreamMock = IngredientStreamMock();
  RecipeIdsStreamMock recipeIdsStreamMock = RecipeIdsStreamMock();
  RecipeOutputStreamMock recipeOutputStreamMock = RecipeOutputStreamMock();
  RecipeFetcherStreamMock recipeFetcherStreamMock = RecipeFetcherStreamMock();
  RepositoryMock repositoryMock = RepositoryMock();

  RecipeBloc bloc = RecipeBloc.forTests(
      recipeTypeStreamMock,
      ingredientTypeStreamMock,
      ingredientStreamMock,
      recipeIdsStreamMock,
      recipeOutputStreamMock,
      recipeFetcherStreamMock,
      repositoryMock,
      [],
      [],
      Map(),
      Map());

  // final MockRecipeBloc recipeBlocMock = MockRecipeBloc();

  test("fetchRecipeIds adds to correct ids to the stream", () {
    Map recipeTypesMap = {"Suppe": false, "Pasta": false, "Hauptgericht": true};
    Map ingredientsMap = {"Heidelbeeren": false, "Apfel": false, "Milch": true};
    bloc = RecipeBloc.forTests(
        recipeTypeStreamMock,
        ingredientTypeStreamMock,
        ingredientStreamMock,
        recipeIdsStreamMock,
        recipeOutputStreamMock,
        recipeFetcherStreamMock,
        repositoryMock,
        [],
        [],
        recipeTypesMap,
        ingredientsMap);
    bloc.fetchRecipeIds();

    verify(repositoryMock.fetchRecipeIds(["Hauptgericht"], ["Milch"]));
  });

  test("fetchRecipeTypes adds the returned types to the stream", () {});

  test("fetchRecipeTypes adds types to the recipeTypesList", () {});

  test("fetchIngredientTypes adds the returned types to the stream", () {});

  test("fetchIngredient adds the returned ingredients to the stream", () {});

  test("fetchIngredients adds ingredients to the ingredientsList", () {});

  group("Testing stream behavior", () {
    // blocTest(
    //   "get recipeIds returns a List of RecipeIdModel",
    //   build: () => MockRecipeBloc(),
    //   act: (MockRecipeBloc bloc) => bloc.fetchRecipeIds(),
    //   expect: [],
    // );

    blocTest("get recipes returns a map of RecipeIdModels and RecipeModels",
        build: null, expect: null);

    blocTest("get recipeTypes returns a List of Strings",
        build: null, expect: null);

    blocTest("get ingredientTypes returns a List of strings",
        build: null, expect: null);

    blocTest("get ingredients returns a List of strings",
        build: null, expect: null);

    blocTest("get fetchRecipe returns a Recipe", build: null, expect: null);
  });
}
