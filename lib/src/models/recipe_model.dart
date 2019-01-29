class RecipeModel {
  final int id;
  final String title;
  final String type;
  final String preparationText;
  final int preparationTimeInMinutes;
  final String imgUrl;
  final List<String> ingredients;

  RecipeModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        title = parsedJson["title"],
        type = parsedJson["type"],
        preparationText = parsedJson["preparationText"],
        preparationTimeInMinutes = parsedJson["preparationTimeInMinutes"],
        imgUrl = parsedJson["imgUrl"],
        ingredients = parsedJson["ingredients"];
}
