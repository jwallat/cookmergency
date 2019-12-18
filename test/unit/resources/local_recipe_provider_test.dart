import 'package:cookmergency/src/data/daos/ingredient_amount_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_dao.dart';
import 'package:cookmergency/src/data/daos/ingredient_type_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_ids_dao.dart';
import 'package:cookmergency/src/data/daos/recipe_type_dao.dart';
import 'package:cookmergency/src/data/moor_database.dart';
import 'package:cookmergency/src/models/ingredient_model.dart';
import 'package:cookmergency/src/models/recipe_model.dart';
import 'package:cookmergency/src/resources/local_recipe_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class IngredientAmountDaoMock extends Mock implements IngredientAmountDao {}

class IngredientDaoMock extends Mock implements IngredientDao {}

class IngredientTypeDaoMock extends Mock implements IngredientTypeDao {}

class RecipeDaoMock extends Mock implements RecipeDao {}

class RecipeIdDaoMock extends Mock implements RecipeIdDao {}

class RecipeTypeDaoMock extends Mock implements RecipeTypeDao {}

void main() {
  test("fetchRecipe calls recipeDao", () async {
    final int EXPECTED_ID = 101;
    final String TITLE = "Title";
    final RecipeDaoMock mock = RecipeDaoMock();
    final IngredientAmountDaoMock iaMock = IngredientAmountDaoMock();
    final Recipe RETURNED_RECIPE = Recipe(
        id: 0,
        title: TITLE,
        imageUrl: 'url',
        preparationText: 'Text',
        preparationTime: '0',
        recipeType: 'Food',
        syncDate: null);
    when(mock.fetchRecipe(EXPECTED_ID))
        .thenAnswer((_) => Future<Recipe>.value(RETURNED_RECIPE));
    when(iaMock.getAllIngredientAmountsForRecipe(TITLE))
        .thenAnswer((_) => Future<List<IngredientAmount>>.value([]));

    final LocalRecipeProvider provider = LocalRecipeProvider.fromDaos(
        recipeDao: mock, ingredientAmountDao: iaMock);

    provider.fetchRecipe(EXPECTED_ID);
    verify(mock.fetchRecipe(EXPECTED_ID));
  });

  test("fetchRecipe constructs the correct return object", () async {
    final int EXPECTED_ID = 101;
    final String TITLE = "Title";

    final RecipeModel EXPECTED_MODEL = RecipeModel.fromData(
      title: TITLE,
      type: 'Type',
      imgUrl: 'url',
      preparationText: 'Text',
      ingredients: [
        IngredientAmountModel.fromValues(
          id: 0,
          amount: "0",
          unit: "unit",
          ingredientName: "Ingredient",
          recipeTitle: TITLE,
        )
      ],
    );

    final RecipeDaoMock mock = RecipeDaoMock();
    final IngredientAmountDaoMock iaMock = IngredientAmountDaoMock();
    final Recipe RETURNED_RECIPE = Recipe(
        id: EXPECTED_ID,
        title: TITLE,
        imageUrl: 'url',
        preparationText: 'Text',
        preparationTime: '0',
        recipeType: 'Food',
        syncDate: null);
    final IngredientAmount IA = IngredientAmount(
        id: 0,
        amount: 0,
        amountUnit: 'Unit',
        ingredientName: 'Ingredient',
        recipeTitle: TITLE,
        syncDate: null);

    when(mock.fetchRecipe(EXPECTED_ID))
        .thenAnswer((_) => Future<Recipe>.value(RETURNED_RECIPE));
    when(iaMock.getAllIngredientAmountsForRecipe(TITLE))
        .thenAnswer((_) => Future<List<IngredientAmount>>.value([IA]));

    final LocalRecipeProvider provider = LocalRecipeProvider.fromDaos(
        recipeDao: mock, ingredientAmountDao: iaMock);

    expectLater(
        (await provider.fetchRecipe(EXPECTED_ID)).title, EXPECTED_MODEL.title);
    expectLater((await provider.fetchRecipe(EXPECTED_ID)).imgUrl,
        EXPECTED_MODEL.imgUrl);
    expectLater(
        (await provider.fetchRecipe(EXPECTED_ID)).ingredients[0].ingredientName,
        EXPECTED_MODEL.ingredients[0].ingredientName);
    expectLater((await provider.fetchRecipe(EXPECTED_ID)).preparationText,
        EXPECTED_MODEL.preparationText);
  });

  test("fetchRecipeTypes returns the correct values", () async {
    final List<String> RECIPE_TYPES = ["1", "2"];
    final List<RecipeType> RECIPE_TYPES_RETURN = [
      RecipeType(id: 0, name: '1', syncDate: null),
      RecipeType(id: 1, name: '2', syncDate: null)
    ];

    final RecipeTypeDaoMock mock = RecipeTypeDaoMock();
    when(mock.fetchAllRecipeTypes())
        .thenAnswer((_) => Future<List<RecipeType>>.value(RECIPE_TYPES_RETURN));

    final LocalRecipeProvider provider =
        LocalRecipeProvider.fromDaos(recipeTypeDao: mock);

    expectLater(await provider.fetchRecipeTypes(), RECIPE_TYPES);
  });

  test("fetchIngredientTypes returns the correct values", () async {
    final List<String> INGREDIENT_TYPES = ["1", "2"];
    // final List<IngredientType> INGREDIENT_TYPES_RETURN = [
    //   IngredientType(id: 0, name: '1', syncDate: null),
    //   IngredientType(id: 1, name: '2', syncDate: null)
    // ];

    final IngredientTypeDaoMock mock = IngredientTypeDaoMock();
    when(mock.fetchAllIngredientTypes())
        .thenAnswer((_) => Future<List<String>>.value(INGREDIENT_TYPES));

    final LocalRecipeProvider provider =
        LocalRecipeProvider.fromDaos(ingredientTypeDao: mock);

    expectLater(await provider.fetchIngredientTypes(), INGREDIENT_TYPES);
  });

  test("fetchIngredients returns the correct values", () async {
    final List<String> INGREDIENTS = ["1", "2"];

    final IngredientDaoMock mock = IngredientDaoMock();
    when(mock.fetchAllIngredients())
        .thenAnswer((_) => Future<List<String>>.value(INGREDIENTS));

    final LocalRecipeProvider provider =
        LocalRecipeProvider.fromDaos(ingredientDao: mock);

    expectLater(await provider.fetchIngredients(), INGREDIENTS);
  });

  test("fetchRecipeIds calls the DAO with the correct arguments", () async {
    final List<String> CHOSEN_INGREDIENTS = ["1", "2"];
    final List<String> CHOSEN_RECIE_TYPES = ["3", "4"];
    final List<int> RETURNED_IDS = [0];

    final RecipeDaoMock mock = RecipeDaoMock();
    final LocalRecipeProvider provider =
        LocalRecipeProvider.fromDaos(recipeDao: mock);

    when(mock.fetchRecipeIds(CHOSEN_RECIE_TYPES, CHOSEN_INGREDIENTS))
        .thenAnswer((_) => Future<List<int>>.value(RETURNED_IDS));

    provider.fetchRecipeIds(CHOSEN_RECIE_TYPES, CHOSEN_INGREDIENTS);

    verify(mock.fetchRecipeIds(CHOSEN_RECIE_TYPES, CHOSEN_INGREDIENTS))
        .called(1);
    expectLater(
        (await provider.fetchRecipeIds(
                CHOSEN_RECIE_TYPES, CHOSEN_INGREDIENTS))[0]
            .localId,
        RETURNED_IDS[0]);
  });

  test("addRecipe calls the correct daos", () async {
    final RecipeTypeDaoMock recipeTypeMock = RecipeTypeDaoMock();
    final RecipeDaoMock recipeMock = RecipeDaoMock();
    final IngredientTypeDaoMock ingredientTypeMock = IngredientTypeDaoMock();
    final IngredientDaoMock ingredientMock = IngredientDaoMock();
    final IngredientAmountDaoMock ingredientAmountMock =
        IngredientAmountDaoMock();

    final LocalRecipeProvider provider = LocalRecipeProvider.fromDaos(
        recipeDao: recipeMock,
        ingredientAmountDao: ingredientAmountMock,
        ingredientDao: ingredientMock,
        ingredientTypeDao: ingredientTypeMock,
        recipeTypeDao: recipeTypeMock);

    final IngredientAmountModel iaModel = IngredientAmountModel.fromValues(
        id: 0,
        recipeTitle: 'Title',
        ingredientName: 'Ingredient',
        amount: "300",
        unit: "unit");

    final RecipeModel RECIPE_MODEL = RecipeModel.fromData(
        title: 'Title',
        type: 'Type',
        imgUrl: 'url',
        preparationText: 'Text',
        ingredients: [iaModel]);

    when(recipeTypeMock.containsRecipeType(any))
        .thenAnswer((_) => Future.value(false));
    when(ingredientTypeMock.containsIngredientType(any))
        .thenAnswer((_) => Future.value(false));
    when(ingredientMock.containsIngredient(any, any))
        .thenAnswer((_) => Future.value(false));

    await provider.addRecipe(RECIPE_MODEL);

    verify(recipeTypeMock.insertRecipeType(any)).called(1);
    verify(recipeMock.insertRecipe(any)).called(1);
    verify(ingredientTypeMock.insertIngredientType(any)).called(1);
    verify(ingredientMock.insertIngredient(any)).called(1);
    verify(ingredientAmountMock.insertIngredientAmount(any)).called(1);
  });
}
