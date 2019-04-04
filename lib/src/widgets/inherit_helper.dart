import "package:flutter/material.dart";
import "../screens/filter_dialog.dart";

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    Key key,
    @required Widget child,
    this.data,
  }) : super(key: key, child: child);

  final FilterDialogState data;

  static MyInheritedWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyInheritedWidget);
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => true;
}
