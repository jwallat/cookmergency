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
    return StreamBuilder<List<String>>(
      stream: bloc.recipeTypes,
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
                  values[snapshot.data[index]] = value;
                  bloc.setSelectedRecipeType(snapshot.data[index], value);
                });
              },
            );
          },
        );
      },
    );
  }
}
