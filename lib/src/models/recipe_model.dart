import 'package:cookmergency/src/data/moor_database.dart';
import 'package:cookmergency/src/models/recipe_id_model.dart';
import "package:mysql1/mysql1.dart";
import "ingredient_model.dart";

class RecipeModel {
  RecipeIdModel idModel;
  String type;
  String title;
  String preparationText;
  int preparationTimeInMinutes;
  String imgUrl;
  List<IngredientAmountModel> ingredients = <IngredientAmountModel>[];

  RecipeModel.fromDb(Results recipeResult) {
    for (Row row in recipeResult) {
      ingredients.add(IngredientAmountModel.fromRow(row));
      idModel = RecipeIdModel.fromRemoteId(remoteId: row[5]);
      type = row[6];
      title = row[7];
      preparationText = row[8].toString();
      imgUrl = row[9];
    }
    ingredients = ingredients;
  }

  RecipeModel.fromLocalDb(Recipe recipe, List<IngredientAmountModel> iaModels) {
    idModel = RecipeIdModel.fromLocalId(localId: recipe.id);
    type = recipe.recipeType;
    title = recipe.title;
    preparationText = recipe.preparationText;
    imgUrl = recipe.imageUrl;
    ingredients = iaModels;
  }

  RecipeModel.fromData(
      {this.title,
      this.type,
      this.preparationText,
      this.imgUrl,
      this.ingredients});
}
