import 'package:cookmergency/src/models/recipe_id_model.dart';
import 'package:cookmergency/src/models/recipe_model.dart';
import 'package:cookmergency/src/resources/local_recipe_provider.dart';
import 'package:cookmergency/src/resources/remote_recipe_provider.dart';
import 'package:cookmergency/src/resources/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LocalRecipeProviderMock extends Mock implements LocalRecipeProvider {}

class RemoteRecipeProviderMock extends Mock implements RemoteRecipeProvider {}

void main() {
  LocalRecipeProviderMock localMock = LocalRecipeProviderMock();
  RemoteRecipeProviderMock remoteMock = RemoteRecipeProviderMock();
  Repository repo = Repository.fromProviders(
      localRecipeProvider: localMock, remoteRecipeProvider: remoteMock);

  test("fetchIngredients fetches from local DB and remote DB", () async {
    await repo.fetchIngredients();

    verify(localMock.fetchIngredients()).called(1);
    verify(remoteMock.fetchIngredients()).called(1);
  });

  test("fetchIngredientTypes fetches from local DB and remote DB", () async {
    await repo.fetchIngredientTypes();

    verify(localMock.fetchIngredientTypes()).called(1);
    verify(remoteMock.fetchIngredientTypes()).called(1);
  });

  test("fetchRecipeTypes fetches from local DB and remote DB", () async {
    await repo.fetchRecipeTypes();

    verify(localMock.fetchRecipeTypes()).called(1);
    verify(remoteMock.fetchRecipeTypes()).called(1);
  });

  test("fetchRecipeIds fetches from local DB and remote DB", () async {
    when(localMock.fetchRecipeIds(any, any))
        .thenAnswer((_) => Future.value([]));
    when(remoteMock.fetchRecipeIds(any, any))
        .thenAnswer((_) => Future.value([]));

    await repo.fetchRecipeIds([], []);

    verify(localMock.fetchRecipeIds([], [])).called(1);
    verify(remoteMock.fetchRecipeIds([], [])).called(1);
  });

  test("fetchRecipeIds adds remote ids to local db", () async {
    List<RecipeIdModel> remoteIdModels = [
      RecipeIdModel.fromRemoteId(remoteId: 10)
    ];

    when(localMock.fetchRecipeIds(any, any))
        .thenAnswer((_) => Future.value([]));
    when(remoteMock.fetchRecipeIds(any, any))
        .thenAnswer((_) => Future.value(remoteIdModels));

    await repo.fetchRecipeIds([], []);

    verify(localMock.addRemoteRecipeIds(remoteIdModels)).called(1);
  });

  test("fetchRecipe fetches from local DB and remote DB", () async {
    RecipeIdModel idModel = RecipeIdModel.fromLocalId(localId: 0);

    await repo.fetchRecipe(idModel);

    verify(localMock.fetchRecipe(any)).called(1);
  });

  test("fetchRecipe adds remote recipeTypes to local db", () async {
    RecipeIdModel idModel = RecipeIdModel.fromRemoteId(remoteId: 0);
    RecipeModel recipe = RecipeModel.fromData();

    when(remoteMock.fetchRecipe(idModel.remoteId))
        .thenAnswer((_) => Future.value(recipe));

    await repo.fetchRecipe(idModel);

    verify(remoteMock.fetchRecipe(any)).called(1);
    verify(localMock.addRecipe(recipe)).called(1);
  });

  test("addRecipe adds a recipe to local DB", () async {
    await repo.addRecipe(null, null, null, null, null);

    verify(localMock.addRecipe(any));
  });

  test("addRecipe adds the recipe to remote DB", () async {
    // if a direct sync fails, persist information and try later
    await repo.addRecipe(null, null, null, null, null);

    verify(remoteMock.addRecipe(any));
  });
}
