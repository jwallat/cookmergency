import "package:flutter/material.dart";
import "validation_bloc.dart";

export 'validation_bloc.dart';

class ValidationProvider extends InheritedWidget {
  ValidationProvider({Key key, Widget child})
      : bloc = ValidationBloc(),
        super(key: key, child: child);

  final ValidationBloc bloc;

  @override
  bool updateShouldNotify(ValidationProvider oldWidget) => true;

  static ValidationBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ValidationProvider)
            as ValidationProvider)
        .bloc;
  }
}
