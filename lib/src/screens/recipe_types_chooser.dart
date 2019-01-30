import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";

class RecipeTypeChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('What do want to cook?'),
      ),
      body: buildBody(context, bloc),
    );
  }

  Widget buildBody(BuildContext context, RecipeBloc bloc) {
    return Container(
      child: Column(
        children: [
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
    final List<String> recipeTypes = bloc.getRecipeTypes();
    return ListView.builder(
      itemCount: recipeTypes.length,
      itemBuilder: (BuildContext context, int index) {
        return CheckboxListTile(
          title: Text("${recipeTypes[index]}"),
          value: bloc.isSelectedRecipeType(index),
          onChanged: (bool b) {
            bloc.setSelectedRecipeType(index, b);
          },
        );
      },
    );
  }
}
