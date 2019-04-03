import "package:flutter/material.dart";
import "../blocs/recipe_provider.dart";
import "../widgets/choose_ingredients.dart";
import "../widgets/choose_recipes.dart";

class FilterDialog extends StatefulWidget {
  FilterDialogState myState;

  //const FilterDialog({Key key}) : super(key: key);

  @override
  FilterDialogState createState() {
    myState = FilterDialogState();
    return myState;
  }
}

class FilterDialogState extends State<FilterDialog> {
  BuildContext context;

  static Map<String, bool> recipeTypeSelectedValues = <String, bool>{};
  static Map<String, bool> ingredientChooserValues = <String, bool>{};
  RecipeBloc bloc;

  int _selectIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ChooseRecipes(),
    ChooseIngredients(
      ingredientChooserValues: ingredientChooserValues,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bloc = RecipeProvider.of(context);
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Recipes"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, "/recipesList");
            },
            child: const Text(
              "Apply filters",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text("Recipe Types"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hot_tub),
            title: Text("Ingredients"),
          ),
        ],
        currentIndex: _selectIndex,
        fixedColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void changeRecipeTypeSelectedValues(int index, bool value, String data) {
    setState(() {
      recipeTypeSelectedValues[data] = value;
      bloc.setSelectedRecipeType(data, value);
    });
  }

  void addIfAbsentRecipeType(String data) {
    recipeTypeSelectedValues.putIfAbsent(data, () {
      return false;
    });
  }

  bool getValueRecipeType(String key) {
    return recipeTypeSelectedValues[key];
  }

  void changeIngredientChooserValues(int index, bool value, String data) {
    setState(() {
      ingredientChooserValues[data] = value;
      bloc.setSelectedIngredient(data, value);
    });
  }

  void addIfAbsentIngredient(String data) {
    ingredientChooserValues.putIfAbsent(data, () {
      {
        return false;
      }
    });
  }

  bool getValueIngredient(String key) {
    return ingredientChooserValues[key];
  }

  void initIngredientChooserValues() {
    setState(() {
      ingredientChooserValues = bloc.getIngredientsMap();
    });
  }
}
