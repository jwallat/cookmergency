import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";

class RecipeTypeChooser extends StatefulWidget {
  @override
  RecipeTypeChooserState createState() => RecipeTypeChooserState();
}

class RecipeTypeChooserState extends State<RecipeTypeChooser> {
  Map<String, bool> values = <String, bool>{};

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    if (values.isEmpty) {
      values.addAll(bloc.getRecipeTypes());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookmergency :)'),
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
              "Select the recipe types you want to search for :)",
              textScaleFactor: 1.5,
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 16.0,
          ),
          Flexible(
            child: buildRecipeTypeList(context, bloc),
          ),
          const Divider(
            color: Colors.grey,
            height: 16.0,
          ),
          Center(
            child: RaisedButton(
              child: const Text("Continue to ingredient selection!"),
              onPressed: () {
                Navigator.pushNamed(context, "/ingredientsChooser");
              },
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
    );
  }

  Widget buildRecipeTypeList(BuildContext context, RecipeBloc bloc) {
    final List<String> recipeTypes = bloc.getRecipeTypes().keys.toList();
    return ListView.builder(
      itemCount: recipeTypes.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text("${recipeTypes[index]}"),
          value: values[recipeTypes[index]],
          onChanged: (bool value) {
            setState(() {
              values[recipeTypes[index]] = value;
              bloc.setSelectedRecipeType(recipeTypes[index], value);
              //print("changed value of $index to $value");
            });
          },
        );
      },
    );
  }
}
