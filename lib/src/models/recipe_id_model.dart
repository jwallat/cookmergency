import 'package:cookmergency/src/data/moor_database.dart';

class RecipeIdModel {
  int localId;
  int remoteId;

  RecipeIdModel.fromRecipeId(RecipeId recipeId) {
    localId = recipeId.localId ?? -1;
    remoteId = recipeId.remoteId ?? -1;
  }

  RecipeIdModel.fromRemoteId({this.remoteId});

  RecipeIdModel.fromLocalId({this.localId});

  RecipeIdModel.fromString(String modelString) {
    try {
      if (modelString.contains("local") && modelString.contains("remote")) {
        List<String> split = modelString.split("_");
        localId = int.parse(split[0].substring(6));
        remoteId = int.parse(split[1].substring(7));
      } else {
        throw Exception;
      }
    } catch (Exception) {
      print("Error parsing RecipeIdModel String: $modelString");
    }
  }

  String modelAsString() {
    return "local=${localId}_remote=${remoteId}";
  }
}
