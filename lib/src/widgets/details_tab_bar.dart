import 'package:cached_network_image/cached_network_image.dart';
import 'package:cookmergency/src/widgets/rating_bar_widget.dart';
import "package:flutter/material.dart";
import "../models/ingredient_amount_model.dart";
import "../models/recipe_model.dart";

class DetailsTabBar extends StatefulWidget {
  final RecipeModel recipe;

  const DetailsTabBar(this.recipe);

  @override
  State<StatefulWidget> createState() => DetailsTabBarState(recipe: recipe);
}

class DetailsTabBarState extends State<DetailsTabBar> {
  final RecipeModel recipe;
  TabController tabController;

  DetailsTabBarState({this.recipe});

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: DrawerControllerState());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          // margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: ClipRRect(
            child: CachedNetworkImage(
              imageUrl: recipe.imgUrl,
              errorWidget: (context, url, error) => Image.network(
                "https://moorestown-mall.com/noimage.gif",
              ),
            ),
            // borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          // decoration: BoxDecoration(
          //   boxShadow: <BoxShadow>[
          //     BoxShadow(
          //       color: Colors.grey,
          //       blurRadius: 10.0,
          //     )
          //   ],
          // ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildTitleDetails(),
            Divider(),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              alignment: AlignmentDirectional.centerStart,
              child: const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            buildIngredientsList(),
            Divider(),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              alignment: AlignmentDirectional.centerStart,
              child: const Text(
                "Instructions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  // backgroundColor: Colors.amber,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            buildDetailsText(),
          ],
        ),
      ],
    );
  }

  Widget buildTitleDetails() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 4, left: 20),
      alignment: AlignmentDirectional.topStart,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipe.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          Row(
            children: <Widget>[
              Container(
                child: RecipeRatingBar(),
                margin: EdgeInsets.only(top: 12),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 30),
                child: Text(
                  recipe.type,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 30),
                child: Text(
                  recipe.preparationTimeInMinutes ?? "30 min",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildIngredientsList() {
    final List<Widget> ingredientList = <Widget>[];
    for (int i = 0; i < recipe.ingredients.length; i++) {
      ingredientList.add(buildIngredientsWidgets(recipe.ingredients[i]));
    }

    return Container(
      child: Column(
        children: ingredientList,
      ),
      margin: const EdgeInsets.only(top: 8, bottom: 10, left: 20),
      alignment: AlignmentDirectional.centerStart,
    );
  }

  Widget buildDetailsText() {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 10, left: 20),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        recipe.preparationText,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildIngredientsWidgets(IngredientAmountModel ingredient) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              ingredient.amount + " " + ingredient.unit + " ",
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            width: MediaQuery.of(context).size.width / 2 - 20,
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                // color: Colors.lightBlue,
                ),
          ),
          Container(
            child: Text(
              ingredient.ingredientName,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            width: MediaQuery.of(context).size.width / 2 - 20,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: const Color(0x2ff2f2f2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 0,
            color: Colors.white,
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 7),
    );
  }
}
