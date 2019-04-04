import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../screens/filter_dialog.dart";

class RecipeTypesChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);
    final FilterDialogState state = FilterDialog.of(context);

    return Container(
      child: Column(
        children: <Widget>[
          const Center(
            child: Text(
              "What do you want to cook?",
              textScaleFactor: 1.5,
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 16.0,
          ),
          Flexible(
            child: buildRecipeTypeList(context, bloc, state),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
    );
  }

  Widget buildRecipeTypeList(
      BuildContext context, RecipeBloc bloc, FilterDialogState state) {
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
            state.addIfAbsentRecipeType(snapshot.data[index]);

            return CheckboxListTile(
              title: Text(snapshot.data[index]),
              value: state.getValueRecipeType(snapshot.data[index]),
              onChanged: (bool value) {
                print("changed recipe type ${snapshot.data[index]}");
                state.changeRecipeTypeSelectedValues(
                    index, value, snapshot.data[index]);
              },
            );
          },
        );
      },
    );
  }
}
