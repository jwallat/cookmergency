import "dart:async";
import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../models/recipe_model.dart";

class RecipeListTile extends StatelessWidget {
  final int recipeId;

  const RecipeListTile({this.recipeId});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return StreamBuilder<Map<int, Future<RecipeModel>>>(
      stream: bloc.recipes,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Future<RecipeModel>>> snapshot) {
        if (!snapshot.hasData) {
          // TODO: Loading Container
          return const Text("snapshot no data");
        }

        return FutureBuilder<RecipeModel>(
            future: snapshot.data[recipeId],
            builder: (BuildContext context,
                AsyncSnapshot<RecipeModel> recipeSnapshot) {
              if (!recipeSnapshot.hasData) {
                // TODO: Loading Container
                return const Text("recipeSnapshot no data");
              }

              return buildTile(context, recipeSnapshot.data);
            });
      },
    );
  }

  Widget buildTile(BuildContext context, RecipeModel recipe) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(recipe.title),
          subtitle: const Text("Maybe score on a later date"),
          trailing: Image.network(
            recipe.imgUrl,
            height: 90,
            width: 90,
          ),
          onTap: () => Navigator.pushNamed(context, "/${recipe.id}"),
        ),
        Divider(),
      ],
    );
  }
}
