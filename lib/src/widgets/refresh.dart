import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final RecipeBloc bloc = RecipeProvider.of(context);

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc.fetchRecipeIds();
      },
    );
  }
}
