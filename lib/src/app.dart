import "package:flutter/material.dart";
import "blocs/recipe_provider.dart";
import "screens/ingredients_chooser.dart";
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
          bloc.loadRecipeTypes();
          bloc.loadIngredients();
          return RecipeTypeChooser();
        },
      );
    } else if (settings.name == "/ingredientsChooser") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
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
          return RecipeTypeChooser();
        },
      );
    }
  }
}
