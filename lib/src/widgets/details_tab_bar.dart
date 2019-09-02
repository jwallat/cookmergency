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
    // return SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       Stack(
    //         alignment: AlignmentDirectional.bottomCenter,
    //         fit: StackFit.loose,
    //         children: <Widget>[
    //           // ImageSliderWidget(
    //           //   imageUrls: <String>[recipe.imgUrl],
    //           //   imageBorderRadius: BorderRadius.zero,
    //           // ),
    //           Image.network(
    //             recipe.imgUrl,
    //             fit: BoxFit.fill,
    //             alignment: Alignment.topCenter,
    //           ),
    //           Container(
    //             alignment: Alignment.center,
    //             child: Text(
    //               recipe.title,
    //               style: const TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: const BorderRadius.only(
    //                 topLeft: Radius.circular(20),
    //                 topRight: Radius.circular(20),
    //               ),
    //             ),
    //             height: 40,
    //           ),
    //         ],
    //       ),
    //       Divider(),
    //       Container(
    //         child: const Text(
    //           "Zubereitung",
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //             // backgroundColor: Colors.amber,
    //           ),
    //           textAlign: TextAlign.left,
    //         ),
    //         margin: const EdgeInsets.only(left: 8, right: 8),
    //       ),
    //       buildDetailsText(),
    //       Divider(),
    //       Container(
    //         child: const Text(
    //           "Zutaten",
    //           style: TextStyle(
    //             fontSize: 16,
    //             fontWeight: FontWeight.bold,
    //           ),
    //           textAlign: TextAlign.left,
    //         ),
    //         margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
    //       ),
    //       buildIngredientsList(),
    //     ],
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //   ),
    // );
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 80, bottom: 10),
          child: Text(
            recipe.title,
            style: const TextStyle(
              fontSize: 26,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: ClipRRect(
            child: Image.network(
              recipe.imgUrl,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
              )
            ],
          ),
        ),
        Container(
          child: const Text(
            "Zutaten",
            style: TextStyle(
              fontSize: 22,
              // fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          margin: const EdgeInsets.only(bottom: 8),
        ),
        buildIngredientsList(),
        Container(
          child: const Text(
            "Zubereitung",
            style: TextStyle(
              fontSize: 22,
              // fontWeight: FontWeight.bold,
              // backgroundColor: Colors.amber,
            ),
            textAlign: TextAlign.left,
          ),
          // margin: const EdgeInsets.only(left: 8, right: 8),
        ),
        buildDetailsText(),
      ],
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
      margin: const EdgeInsets.only(bottom: 40),
    );
  }

  Widget buildDetailsText() {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: Text(
        recipe.preparationText,
        style: const TextStyle(
          fontSize: 16,
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
                fontSize: 16,
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
        color: const Color(0xfff2f2f2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 0,
            color: Colors.grey,
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 7),
    );
  }
}
