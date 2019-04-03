import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../screens/filter_dialog.dart";

class ChooseRecipes extends StatelessWidget {
  FilterDialogState parentState;

  ChooseRecipes({this.parentState});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    final FilterDialog fd = context.ancestorWidgetOfExactType(FilterDialog);
    parentState = fd?.myState;

    print(parentState);

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
            parentState.addIfAbsentRecipeType(snapshot.data[index]);

            return CheckboxListTile(
              title: Text(snapshot.data[index]),
              value: parentState.getValueRecipeType(snapshot.data[index]),
              onChanged: (bool value) {
                print("changed recipe type ${snapshot.data[index]}");
                parentState.changeRecipeTypeSelectedValues(
                    index, value, snapshot.data[index]);
              },
            );
          },
        );
      },
    );
  }
}
