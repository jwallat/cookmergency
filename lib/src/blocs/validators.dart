import "dart:async";

class Validators {
  final StreamTransformer<String, String> validateTitle =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String title, EventSink<String> sink) {
      if (title.isEmpty) {
        sink.addError("Please enter a title");
      } else {
        // check if there is already an recipe with that title in db
        // TODO: Add check in db
        if (false) {
          sink.addError("Title already taken, please choose another title!");
        }
        sink.add(title);
      }
    },
  );

  final StreamTransformer<String, String> validateRecipeType =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String recipeType, EventSink<String> sink) {
      if (recipeType.isEmpty) {
        sink.addError("Please enter a recipe type!");
      } else {
        // TODO: More checks
        sink.add(recipeType);
      }
    },
  );

  final StreamTransformer<String, String> validatePreperationText =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String prepText, EventSink<String> sink) {
      if (prepText.isNotEmpty) {
        sink.add(prepText);
      } else {
        sink.addError("Please enter a preperation text!");
      }
    },
  );

  final StreamTransformer<String, String> validateImageURL =
      StreamTransformer<String, String>.fromHandlers(
    handleData: (String imageURL, EventSink<String> sink) {
      if (imageURL.isNotEmpty) {
        sink.add(imageURL);
      } else {
        sink.addError("Please enter a image url!");
      }
    },
  );

  final StreamTransformer<List<String>, List<String>> validateIngredients =
      StreamTransformer<List<String>, List<String>>.fromHandlers(
    handleData: (List<String> ingredients, EventSink<List<String>> sink) {
      if (ingredients.isNotEmpty) {
        sink.add(ingredients);
      } else {
        sink.addError("Please enter at least one ingredient!");
      }
    },
  );
}
