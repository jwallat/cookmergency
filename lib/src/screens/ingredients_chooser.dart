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

    if (bloc.getIngredientsMap().isNotEmpty) {
      setState(() {
        values = bloc.getIngredientsMap();
      });
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
    return StreamBuilder<List<String>>(
      stream: bloc.ingredients,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            // fill valuesMap
            values.putIfAbsent(snapshot.data[index], () {
              return false;
            });

            return CheckboxListTile(
              title: Text(snapshot.data[index]),
              value: values[snapshot.data[index]],
              onChanged: (bool value) {
                setState(() {
                  bloc.setSelectedIngredient(snapshot.data[index], value);
                  values[snapshot.data[index]] = value;
                });
              },
            );
          },
        );
      },
    );
  }
}
