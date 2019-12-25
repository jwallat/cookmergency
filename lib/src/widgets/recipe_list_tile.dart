import "dart:async";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookmergency/src/models/recipe_id_model.dart';
import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../models/recipe_model.dart";
import "../widgets/loading_container.dart";

class RecipeListTile extends StatelessWidget {
  final RecipeIdModel recipeIdModel;

  const RecipeListTile({this.recipeIdModel});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return StreamBuilder<Map<RecipeIdModel, Future<RecipeModel>>>(
      stream: bloc.recipes,
      builder: (BuildContext context,
          AsyncSnapshot<Map<RecipeIdModel, Future<RecipeModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder<RecipeModel>(
            future: snapshot.data[recipeIdModel],
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
    return Card(
      child: ListTile(
        title: Text(recipe.title),
        subtitle: const Text("Maybe score on a later date"),
        leading: ClipRRect(
          child: CachedNetworkImage(
            imageUrl: recipe.imgUrl,
            width: 90,
            height: 90,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Image.network(
                "https://moorestown-mall.com/noimage.gif",
                height: 90,
                width: 90),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(3.0)),
        ),
        onTap: () =>
            Navigator.pushNamed(context, "/${recipe.idModel.modelAsString()}"),
      ),
    );
  }
}
