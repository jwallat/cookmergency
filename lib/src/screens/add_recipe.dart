import 'package:cookmergency/src/blocs/recipe_provider.dart';
import 'package:cookmergency/src/models/ingredient_model.dart';
import "package:flutter/material.dart";
import "package:autocomplete_textfield/autocomplete_textfield.dart";
import "../blocs/validation_provider.dart";
import "../widgets/added_ingreident_tile.dart";

class AddRecipe extends StatefulWidget {
  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipe> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> ingredientsKey = GlobalKey();
  final TextEditingController _amountTextController = TextEditingController();
  GlobalKey<AutoCompleteTextFieldState<String>> amountKey = GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> unitKey = GlobalKey();
  String chosenRecipeType = "";
  IngredientAmountModel currentIngredient = IngredientAmountModel.fromNothing();
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
              ingredientsTextField(validationBloc, recipeBloc),
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
    print(recipeTypeSuggestions);

    return SimpleAutoCompleteTextField(
      key: key,
      suggestions: recipeTypeSuggestions,
      decoration: InputDecoration(
        labelText: "Recipe Type",
        hintText: "Currys",
      ),
      textChanged: (String recipeType) {
        setState(() {
          chosenRecipeType = recipeType;
        });
      },
      textSubmitted: (String recipeType) {
        setState(() {
          chosenRecipeType = recipeType;
        });
      },
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

  Widget ingredientsTextField(
      ValidationBloc validationBloc, RecipeBloc recipeBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.ingredients,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // return const Text("Ingredients here...to be changed...");
        return Column(
          children: <Widget>[
            ingredientsAdder(recipeBloc, snapshot),
            Divider(),
            const Text(
              "Ingredients",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
            ),
            ingredientsList(),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        );
      },
    );
  }

  Widget ingredientsAdder(
      RecipeBloc recipeBloc, AsyncSnapshot<dynamic> snapshot) {
    final List<String> ingredientsSuggestions = recipeBloc.ingredientsList;
    print(ingredientsSuggestions);
    // TODO: add real unit suggestions from db
    final List<String> unitSuggestions = ["g", "kg", "Stk."];

    return Row(
      children: <Widget>[
        Expanded(
          child: SimpleAutoCompleteTextField(
            textChanged: (String name) {
              print("submitted");
              setState(() {
                currentIngredient.ingredientName = name;
              });
            },
            textSubmitted: (String name) {
              print("submitted");
              setState(() {
                currentIngredient.ingredientName = name;
              });
            },
            key: ingredientsKey,
            suggestions: ingredientsSuggestions,
            decoration: InputDecoration(
              labelText: "Ingredient",
              hintText: "Sugar",
            ),
            clearOnSubmit: false,
            submitOnSuggestionTap: true,
            onFocusChanged: (bool hasFocus) {},
          ),
        ),
        Container(
          child: TextField(
            onChanged: (String amount) {
              setState(() {
                print("submitted");
                currentIngredient.amount = amount;
                validationBloc.changeIngredientAmount;
              });
            },
            key: amountKey,
            controller: _amountTextController,
            decoration: InputDecoration(
              labelText: "Amount",
              hintText: "300",
              errorText: snapshot.error,
            ),
          ),
          width: 100,
        ),
        Container(
          child: SimpleAutoCompleteTextField(
            textChanged: (String unit) {
              print("submitted");
              currentIngredient.unit = unit;
            },
            textSubmitted: (String unit) {
              print("submitted");
              setState(() {
                currentIngredient.unit = unit;
              });
            },
            key: unitKey,
            suggestions: unitSuggestions,
            decoration: InputDecoration(
              labelText: "Unit",
              hintText: "g",
            ),
            clearOnSubmit: false,
            submitOnSuggestionTap: true,
            onFocusChanged: (bool hasFocus) {},
          ),
          width: 80,
        ),
        Container(
          child: FlatButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                ingredientsKey.currentState.clear();
                print("1");
                _amountTextController.clear();
                print("2");
                unitKey.currentState.clear();
                print("3");
                print(
                    "${currentIngredient.ingredientName} # ${currentIngredient.amount} # ${currentIngredient.unit}");
                chosenIngredients.add(currentIngredient);
                currentIngredient = IngredientAmountModel.fromNothing();
              });
            },
          ),
          width: 50,
        ),
      ],
    );
  }

  Widget ingredientsList() {
    return Column(
      children: <Widget>[
        if (chosenIngredients.isEmpty)
          Center(
            child: const Text("Please add ingredients to your new recipe!"),
          ),
        for (IngredientAmountModel ia in chosenIngredients)
          AddedIngredientTile(
            model: ia,
            selfdestructionCallback: removeIngredientsListItem,
          ),
      ],
    );
  }

  // callback method that is used to delete items from the chosenIngredients
  // list that shows the cards of chosen ingredients
  void removeIngredientsListItem(IngredientAmountModel item) {
    setState(() {
      chosenIngredients.remove(item);
    });
  }

  Widget submitButton(ValidationBloc validationBloc) {
    return StreamBuilder<dynamic>(
      stream: validationBloc.submitValid,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return RaisedButton(
          child: const Text("Submit"),
          color: Colors.blue,
          onPressed: ((!snapshot.hasData || !snapshot.data) ||
                  chosenIngredients.isEmpty ||
                  chosenRecipeType.isEmpty)
              ? null
              : () => validationBloc
                      .submit(chosenIngredients, chosenRecipeType)
                      .then((bool success) {
                    success
                        ? Navigator.pushNamed(context, "/")
                        : print("Adding unsuccessful!");
                    // TODO(jw): Should delete all the stuff if not successful
                  }),
        );
      },
    );
  }
}
