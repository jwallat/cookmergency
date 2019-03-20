import "package:sqljocky5/sqljocky.dart";

class RecipeModel {
  int id;
  String type;
  String title;
  String preparationText;
  int preparationTimeInMinutes;
  String imgUrl;
  List<String> ingredients;

  RecipeModel.fromDb(Results recipeResult) {
    for (Row row in recipeResult) {
      id = row[0];
      type = row[1];
      title = row[2];
      preparationText = row[3].toString();
      imgUrl = row[4];
    }
  }
}
