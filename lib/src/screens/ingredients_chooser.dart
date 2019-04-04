import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../screens/filter_dialog.dart";

class IngredientsChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);
    final FilterDialogState state = FilterDialog.of(context);

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
            child: buildIngredientsList(context, bloc, state),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
    );
  }

  Widget buildIngredientsList(
      BuildContext context, RecipeBloc bloc, FilterDialogState state) {
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
            state.addIfAbsentIngredient(snapshot.data[index]);
            return CheckboxListTile(
              title: Text(snapshot.data[index]),
              value: state.getValueIngredient(snapshot.data[index]),
              onChanged: (bool value) {
                state.changeIngredientChooserValues(
                    index, value, snapshot.data[index]);
              },
            );
          },
        );
      },
    );
  }
}
