import "package:flutter/material.dart";
import "blocs/recipe_provider.dart";
import "screens/ingredients_chooser.dart";
import "screens/recipe_details.dart";
import "screens/recipe_types_chooser.dart";
import "screens/recipes_list.dart";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecipeProvider(
      child: MaterialApp(
        title: "Cookmergency!",
        onGenerateRoute: routes,
      ),
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          // load data
          final RecipeBloc bloc = RecipeProvider.of(context);
          print("load data");
          bloc.fetchRecipeTypes();
          return RecipeTypeChooser();
        },
      );
    } else if (settings.name == "/ingredientsChooser") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          // load data
          final RecipeBloc bloc = RecipeProvider.of(context);
          print("load ingredients");
          bloc.fetchIngredientTypes();
          bloc.fetchIngredients();
          return IngredientsChooser();
        },
      );
    } else if (settings.name == "/recipesList") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          // load recipes for bloc
          //final RecipeBloc bloc = RecipeProvider.of(context);

          return RecipesList();
        },
      );
    } else {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          final RecipeBloc recipeBloc = RecipeProvider.of(context);
          final int recipeId = int.parse(settings.name.replaceFirst("/", ""));

          recipeBloc.fetchRecipe(recipeId);

          return RecipeDetails(
            recipeId: recipeId,
          );
        },
      );
    }
  }
}
