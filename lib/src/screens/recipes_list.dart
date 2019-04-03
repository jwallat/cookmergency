import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../widgets/recipe_list_tile.dart";
import "../widgets/refresh.dart";

class RecipesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cookmergency :)"),
      ),
      body: buildBody(context, bloc),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("clicked");
          Navigator.pushNamed(context, "/filter");
        },
        child: const Icon(Icons.details),
      ),
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

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              bloc.fetchRecipe(snapshot.data[index]);

              return RecipeListTile(
                recipeId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
