import 'package:cookmergency/src/data/moor_database.dart';
import "package:mysql1/mysql1.dart";

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

  IngredientAmountModel.fromLocalDB(IngredientAmount ia) {
    id = ia.id;
    ingredientName = ia.ingredientName;
    recipeTitle = ia.recipeTitle;
    amount = ia.amount.toString();
    unit = ia.amountUnit;
  }

  IngredientAmountModel.fromNothing() {}

  IngredientAmountModel.fromValues(
      {this.id, this.ingredientName, this.recipeTitle, this.amount, this.unit});
}
