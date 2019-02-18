import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";

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
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: const <Widget>[
          Text(
            "Title",
            style: TextStyle(fontSize: 14),
          ),
          Divider(),
          Text("Zutaten"),
          Divider(),
          Text("Anleitung"),
        ],
      ),
    );
  }
}
