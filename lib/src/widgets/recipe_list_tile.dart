import "dart:async";
import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../models/recipe_model.dart";
import "../widgets/loading_container.dart";

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
          return LoadingContainer();
        }

        return FutureBuilder<RecipeModel>(
            future: snapshot.data[recipeId],
            builder: (BuildContext context,
                AsyncSnapshot<RecipeModel> recipeSnapshot) {
              if (!recipeSnapshot.hasData) {
                return LoadingContainer();
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
            fit: BoxFit.fill,
          ),
          onTap: () => Navigator.pushNamed(context, "/${recipe.id}"),
        ),
        const Divider(),
      ],
    );
  }
}
