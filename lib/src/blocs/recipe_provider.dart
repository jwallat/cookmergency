import "package:flutter/material.dart";
import "recipe_bloc.dart";

export 'recipe_bloc.dart';

class RecipeProvider extends InheritedWidget {
  RecipeProvider({Key key, Widget child})
      : bloc = RecipeBloc(),
        super(key: key, child: child);

  final RecipeBloc bloc;

  @override
  bool updateShouldNotify(RecipeProvider oldWidget) => true;

  static RecipeBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(RecipeProvider)
            as RecipeProvider)
        .bloc;
  }
}
