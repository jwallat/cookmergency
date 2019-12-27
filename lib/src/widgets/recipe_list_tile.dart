import "dart:async";
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookmergency/src/models/recipe_id_model.dart';
import 'package:cookmergency/src/widgets/rating_bar_widget.dart';
import "package:flutter/material.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
        subtitle: buildSubtitle(recipe),
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

  Widget buildSubtitle(RecipeModel recipe) {
    Random rnd = Random();
    return Row(
      children: <Widget>[
        Container(
          child: RatingBar(
            initialRating: rnd.nextDouble() * 5,
            allowHalfRating: true,
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemCount: 5,
            itemSize: 15.0,
            onRatingUpdate: null,
          ),
          margin: EdgeInsets.only(top: 12),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 30),
          child: Text(
            recipe.preparationTimeInMinutes ?? "30 min",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
