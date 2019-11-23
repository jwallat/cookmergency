import 'package:cookmergency/src/data/daos/recipe_dao.dart';
import 'package:cookmergency/src/resources/local_recipe_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class RecipeDaoMock extends Mock implements RecipeDao {}

void main() {
  test("fetchRecipe calls recipeDao", () async {
    final int EXPECTED_ID = 101;
    final RecipeDaoMock mock = RecipeDaoMock();

    final LocalRecipeProvider provider =
        LocalRecipeProvider.fromDaos(recipeDao: mock);

    provider.fetchRecipe(EXPECTED_ID);
    verify(mock.fetchRecipe(EXPECTED_ID));
  });
}
