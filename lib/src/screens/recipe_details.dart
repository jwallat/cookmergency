import "dart:async";
import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../models/recipe_model.dart";
import "../widgets/details_tab_bar.dart";

class RecipeDetails extends StatelessWidget {
  final int recipeId;

  const RecipeDetails({this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          buildDetails(bloc),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              // title: const Text("Cookmergency :)"),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetails(RecipeBloc bloc) {
    // retrieve right RecipeModel from bloc with recipeId
    return StreamBuilder<Map<int, Future<RecipeModel>>>(
      stream: bloc.recipes,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<RecipeModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: const CircularProgressIndicator());
        }

        final Future<RecipeModel> recipeFuture = snapshot.data[recipeId];

        return FutureBuilder<RecipeModel>(
          future: recipeFuture,
          builder: (BuildContext context,
              AsyncSnapshot<RecipeModel> recipeSnapshot) {
            if (!recipeSnapshot.hasData) {
              return Center(child: const CircularProgressIndicator());
            }
            return buildRecipeDetails(recipeSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildRecipeDetails(RecipeModel recipe) {
    return Container(
      child: DetailsTabBar(recipe),
    );
  }
}
