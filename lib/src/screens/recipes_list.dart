import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";

class RecipesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cookmergency :)"),
      ),
      body: buildBody(context, bloc),
    );
  }

  Widget buildBody(BuildContext context, RecipeBloc bloc) {
    return buildRecipeList(context, bloc);
  }

  Widget buildRecipeList(BuildContext context, RecipeBloc bloc) {
    return //Text("Ok");
        StreamBuilder<List<int>>(
      stream: bloc.recipeIds,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("${snapshot.data[index]}"),
            );
          },
        );
      },
    );
  }
}
