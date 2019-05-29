import "package:flutter/material.dart";
import "../models/ingredient_model.dart";
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            fit: StackFit.loose,
            children: <Widget>[
              // ImageSliderWidget(
              //   imageUrls: <String>[recipe.imgUrl],
              //   imageBorderRadius: BorderRadius.zero,
              // ),
              Image.network(
                recipe.imgUrl,
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  recipe.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: 40,
              ),
            ],
          ),
          Divider(),
          Container(
            child: const Text(
              "Zubereitung",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // backgroundColor: Colors.amber,
              ),
              textAlign: TextAlign.left,
            ),
            margin: const EdgeInsets.only(left: 8, right: 8),
          ),
          buildDetailsText(),
          Divider(),
          Container(
            child: const Text(
              "Zutaten",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          ),
          buildIngredientsList(),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  Widget buildIngredientsList() {
    final List<Row> ingredientList = <Row>[];
    for (int i = 0; i < recipe.ingredients.length; i++) {
      final Row ingredientRow = Row(
        children: buildIngredientsWidgets(recipe.ingredients[i]),
        mainAxisAlignment: MainAxisAlignment.center,
      );
      ingredientList.add(ingredientRow);
    }

    return Container(
      child: Column(
        children: ingredientList,
      ),
      margin: const EdgeInsets.only(bottom: 40),
    );
  }

  Widget buildDetailsText() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Text(
        recipe.preparationText,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  List<Widget> buildIngredientsWidgets(IngredientAmountModel ingredient) {
    final List<Widget> ingredients = <Widget>[
      Container(
        child: Text(ingredient.ingredientName),
        width: 170,
        alignment: Alignment.centerLeft,
      ),
      Container(
        child: Text(ingredient.amount),
        width: 124,
        alignment: Alignment.center,
      ),
      Container(
        child: Text(ingredient.unit),
        width: 100,
        alignment: Alignment.centerRight,
      )
    ];

    return ingredients;
  }
}
