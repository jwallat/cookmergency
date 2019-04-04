import "package:sqljocky5/sqljocky.dart";
import "ingredient_model.dart";

class RecipeModel {
  int id;
  String type;
  String title;
  String preparationText;
  int preparationTimeInMinutes;
  String imgUrl;
  List<IngredientAmountModel> ingredients = <IngredientAmountModel>[];

  RecipeModel.fromDb(Results recipeResult) {
    for (Row row in recipeResult) {
      ingredients.add(IngredientAmountModel.fromRow(row));
      id = row[5];
      type = row[6];
      title = row[7];
      preparationText = row[8].toString();
      imgUrl = row[9];
    }
    ingredients = ingredients;
  }
}
