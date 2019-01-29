import "recipe_bloc.dart";
import "package:flutter/material.dart";
import "package:rxdart/rxdart.dart";

export 'recipe_bloc.dart';

class RecipeProvider extends InheritedWidget {
  final RecipeBloc bloc;

  RecipeProvider({Key key, Widget child})
      : bloc = RecipeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static RecipeBloc of(BuildContext context) {
    print("before bloc");
    return (context.inheritFromWidgetOfExactType(RecipeProvider)
            as RecipeProvider)
        .bloc;
  }
}
