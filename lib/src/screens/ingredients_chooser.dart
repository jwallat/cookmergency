import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";

class IngredientsChooser extends StatefulWidget {
  @override
  IngredientsChooserState createState() => IngredientsChooserState();
}

class IngredientsChooserState extends State<IngredientsChooser> {
  Map<String, bool> values = <String, bool>{};

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    if (values.isEmpty) {
      values.addAll(bloc.getIngredients());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cookmergency :)"),
      ),
      body: buildBody(context, bloc),
    );
  }

  Widget buildBody(BuildContext context, RecipeBloc bloc) {
    return Container(
      child: Column(
        children: <Widget>[
          const Center(
            child: Text(
              "Select the ingredients that you have :)",
              textScaleFactor: 1.5,
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 16.0,
          ),
          Flexible(
            child: buildIngredientsList(context, bloc),
          ),
          const Divider(
            color: Colors.grey,
            height: 16.0,
          ),
          Center(
            child: RaisedButton(
              child: const Text("Show matching recipes!"),
              onPressed: () {
                Navigator.pushNamed(context, "/recipesList");
              },
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
    );
  }

  Widget buildIngredientsList(BuildContext context, RecipeBloc bloc) {
    final List<String> ingredients = bloc.getIngredients().keys.toList();
    return ListView.builder(
      itemCount: ingredients.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text("${ingredients[index]}"),
          value: values[ingredients[index]],
          onChanged: (bool value) {
            setState(() {
              bloc.setSelectedIngredient(ingredients[index], value);
              values[ingredients[index]] = value;
            });
          },
        );
      },
    );
  }
}
