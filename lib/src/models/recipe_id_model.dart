import 'package:cookmergency/src/data/moor_database.dart';

class RecipeIdModel {
  int localId;
  int remoteId;

  RecipeIdModel.fromRecipeId(RecipeId recipeId) {
    localId = recipeId.localId ?? -1;
    remoteId = recipeId.remoteId ?? -1;
  }

  RecipeIdModel.fromRemoteId(int remoteId) {
    remoteId = remoteId;
  }

  RecipeIdModel.fromLocalId(int localId) {
    localId = localId;
  }
}
