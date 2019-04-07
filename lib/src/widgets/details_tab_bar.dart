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
    return GridView.count(
      crossAxisCount: 1,
      shrinkWrap: true,
      children: <Widget>[
        Image.network(
          recipe.imgUrl,
          fit: BoxFit.fill,
        ),
        Scaffold(
          // backgroundColor: Colors.amber,
          appBar: TabBar(
            tabs: const <Widget>[
              Tab(
                child: Text("Ingredients"),
              ),
              Tab(
                child: Text("Details"),
              ),
            ],
            controller: tabController,
            labelColor: Colors.black,
          ),
          body: Container(
            // color: Colors.amber,
            child: TabBarView(
              children: <Widget>[
                buildIngredientsList(),
                buildDetailsText(),
              ],
              controller: tabController,
            ),
          ),
        )
      ],
    );
  }

  Widget buildIngredientsList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemExtent: 20.0,
        itemCount: recipe.ingredients.length,
        itemBuilder: (BuildContext context, int index) {
          final IngredientAmountModel ingredient = recipe.ingredients[index];

          return Row(
            children: buildIngredientsWidgets(ingredient),
            mainAxisAlignment: MainAxisAlignment.center,
          );
        },
      ),
    );
  }

  Widget buildDetailsText() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Text(
        recipe.preparationText,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  List<Widget> buildIngredientsWidgets(IngredientAmountModel ingredient) {
    final List<Widget> ingredients = [
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
