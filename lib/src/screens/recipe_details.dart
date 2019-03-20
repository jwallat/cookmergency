import "dart:async";
import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../models/recipe_model.dart";

class RecipeDetails extends StatelessWidget {
  final int recipeId;

  const RecipeDetails({this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cookmergency :)"),
      ),
      body: buildDetails(bloc),
    );
  }

  Widget buildDetails(RecipeBloc bloc) {
    // retrieve right RecipeModel from bloc with recipeId

    return StreamBuilder<Map<int, Future<RecipeModel>>>(
      stream: bloc.recipes,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<RecipeModel>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text("Loading");
        }

        final Future<RecipeModel> recipeFuture = snapshot.data[recipeId];

        return FutureBuilder<RecipeModel>(
          future: recipeFuture,
          builder: (BuildContext context,
              AsyncSnapshot<RecipeModel> recipeSnapshot) {
            if (!recipeSnapshot.hasData) {
              return const Text("Item still loading");
            }

            return buildRecipeDetails(recipeSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildRecipeDetails(RecipeModel recipe) {
    return Text(recipe.preparationText);
  }
}
