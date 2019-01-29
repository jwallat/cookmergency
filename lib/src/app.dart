import "package:flutter/material.dart";
import "screens/recipe_types_chooser.dart";
import "blocs/recipe_provider.dart";

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RecipeProvider(
      child: MaterialApp(
        title: "Cookmergency!",
        home: RecipeTypeChooser(),
      ),
    );
  }
}
