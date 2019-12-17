import 'package:cookmergency/src/models/recipe_id_model.dart';
import "package:flutter/material.dart";
import "blocs/recipe_provider.dart";
import "blocs/validation_provider.dart";
import "screens/add_recipe.dart";
import "screens/filter_dialog.dart";
import "screens/recipe_details.dart";
import "screens/recipes_list.dart";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecipeProvider(
      child: ValidationProvider(
        child: MaterialApp(
          title: "Cookmergency!",
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route<dynamic> routes(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          // load data
          final RecipeBloc bloc = RecipeProvider.of(context);
          bloc.connectRemoteDB();
          bloc.fetchRecipeTypes();
          bloc.fetchIngredientTypes();
          bloc.fetchIngredients();
          bloc.fetchRecipeIds();

          return RecipesList();
        },
      );
    } else if (settings.name == "/recipesList") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          // load recipes for bloc
          final RecipeBloc bloc = RecipeProvider.of(context);
          bloc.fetchRecipeIds();

          return RecipesList();
        },
      );
    } else if (settings.name == "/filter") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return const FilterDialog();
        },
      );
    } else if (settings.name == "/new") {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return AddRecipe();
        },
      );
    } else {
      return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          final RecipeBloc recipeBloc = RecipeProvider.of(context);
          print("Parsing recipeIdModel: ${settings.name}");
          final RecipeIdModel recipeIdModel =
              RecipeIdModel.fromString(settings.name.replaceFirst("/", ""));

          recipeBloc.fetchRecipe(recipeIdModel);

          return RecipeDetails(
            recipeIdModel: recipeIdModel,
          );
        },
      );
    }
  }
}
