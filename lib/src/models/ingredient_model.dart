import "package:sqljocky5/sqljocky.dart";

class IngredientAmountModel {
  int id;
  String ingredientName;
  String recipeTitle;
  String amount;
  String unit;

  IngredientAmountModel.fromRow(Row row) {
    id = row[0];
    ingredientName = row[1];
    recipeTitle = row[2];
    amount = row[3].toString();
    unit = row[4];
  }
}
