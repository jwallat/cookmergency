import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../screens/filter_dialog.dart";

class ChooseIngredients extends StatelessWidget {
  FilterDialogState parentState;
  Map<String, bool> ingredientChooserValues = <String, bool>{};

  ChooseIngredients({this.ingredientChooserValues, this.parentState});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    parentState =
        context.ancestorInheritedElementForWidgetOfExactType(FilterDialogState)
            as FilterDialogState;

    if (bloc.getIngredientsMap().isNotEmpty) {
      parentState.initIngredientChooserValues();
    }

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
            parentState.addIfAbsentIngredient(snapshot.data[index]);
            return CheckboxListTile(
              title: Text(snapshot.data[index]),
              value: parentState.getValueIngredient(snapshot.data[index]),
              onChanged: (bool value) {
                parentState.changeIngredientChooserValues(
                    index, value, snapshot.data[index]);
              },
            );
          },
        );
      },
    );
  }
}
