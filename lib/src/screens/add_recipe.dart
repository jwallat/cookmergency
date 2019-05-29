import 'package:cookmergency/src/blocs/recipe_provider.dart';
import 'package:cookmergency/src/models/ingredient_model.dart';
import "package:flutter/material.dart";
import "package:autocomplete_textfield/autocomplete_textfield.dart";
import "../blocs/validation_provider.dart";

class AddRecipe extends StatefulWidget {
  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipe> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  String chosenRecipeType = "";
  List<IngredientAmountModel> chosenIngredients = <IngredientAmountModel>[];

  @override
  Widget build(BuildContext context) {
    final ValidationBloc validationBloc = ValidationProvider.of(context);
    final RecipeBloc recipeBloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Recipe"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              titleField(validationBloc),
              Divider(),
              recipeTypeField(validationBloc, recipeBloc),
              Divider(),
              preperationTextField(validationBloc),
              Divider(),
              imageURLTextField(validationBloc),
              Divider(),
              ingredientsTextField(validationBloc),
              Divider(),
              Row(
                children: <Widget>[
                  submitButton(validationBloc),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: const EdgeInsets.all(8),
        ),
      ),
    );
  }

  Widget titleField(ValidationBloc validationBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.title,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: validationBloc.changeTitle,
          decoration: InputDecoration(
            labelText: "Title",
            hintText: "Hausgemachter Apfelstrudel",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget recipeTypeField(ValidationBloc validationBloc, RecipeBloc recipeBloc) {
    final List<String> recipeTypeSuggestions = recipeBloc.recipeTypesList;

    return SimpleAutoCompleteTextField(
      key: key,
      suggestions: recipeTypeSuggestions,
      decoration: InputDecoration(
        labelText: "Recipe Type",
        hintText: "Currys",
      ),
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      onFocusChanged: (bool hasFocus) {},
    );
  }

  Widget preperationTextField(ValidationBloc validationBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.preperationText,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: validationBloc.changePreperationText,
          decoration: InputDecoration(
            labelText: "Preperation Text",
            hintText: "Zuerst Eier und Mehl verrühren...",
            errorText: snapshot.error,
          ),
          minLines: 1,
          maxLines: 4,
        );
      },
    );
  }

  Widget imageURLTextField(ValidationBloc validationBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.imageURL,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return TextField(
          onChanged: validationBloc.changeImageURL,
          decoration: InputDecoration(
            labelText: "Image URL",
            hintText: "www.image.com/yummi_apple_pie",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget ingredientsTextField(ValidationBloc validationBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.ingredients,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return const Text("Ingredients here...to be changed...");
        // return TextField(
        //   onChanged: validationBloc.changeIngredients,
        //   decoration: InputDecoration(
        //     labelText: "Ingreidents",
        //     hintText: "Zutaten hier",
        //     errorText: snapshot.error,
        //   ),
        // );
      },
    );
  }

  Widget submitButton(ValidationBloc validationBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return RaisedButton(
          child: const Text("Submit"),
          color: Colors.blue,
          onPressed: snapshot.hasData ? validationBloc.submit : null,
        );
      },
    );
  }
}
