import "dart:async";
import "package:rxdart/rxdart.dart";
import "../models/ingredient_model.dart";
import "../resources/repository.dart";
import "validators.dart";

class ValidationBloc with Validators {
  final Repository repository = Repository();

  final BehaviorSubject<String> _titleController = BehaviorSubject<String>();
  final BehaviorSubject<String> _recipeTypeController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _preperationTextController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _imageURLController = BehaviorSubject<String>();
  final BehaviorSubject<List<String>> _ingredientsController =
      BehaviorSubject<List<String>>();
  final BehaviorSubject<String> _ingredientAmountController =
      BehaviorSubject<String>();

  // Add data to stream
  Function(String) get changeTitle => _titleController.sink.add;
  Function(String) get changeRecipeType => _recipeTypeController.sink.add;
  Function(String) get changePreperationText =>
      _preperationTextController.sink.add;
  Function(String) get changeImageURL => _imageURLController.sink.add;
  Function(List<String>) get changeIngredients =>
      _ingredientsController.sink.add;
  Function(String) get changeIngredientAmount =>
      _ingredientAmountController.sink.add;

  // Retrieve data from stream
  Stream<String> get title => _titleController.stream.transform(validateTitle);
  Stream<String> get recipeType =>
      _recipeTypeController.stream.transform(validateRecipeType);
  Stream<String> get preperationText =>
      _preperationTextController.stream.transform(validatePreperationText);
  Stream<String> get imageURL =>
      _imageURLController.stream.transform(validateImageURL);
  Stream<List<String>> get ingredients =>
      _ingredientsController.stream.transform(validateIngredients);
  Stream<String> get ingredientAmount =>
      _ingredientAmountController.stream.transform(validateIngredientAmounts);

  Stream<bool> get submitValid => Observable.combineLatest3(
        title,
        preperationText,
        imageURL,
        (dynamic title, dynamic preperationText, dynamic imageURL) => true,
      );

  Future<bool> submit(
      List<IngredientAmountModel> chosenIngredients, String recipeType) async {
    final String validTitle = _titleController.value;
    final String validPreperationText = _preperationTextController.value;
    final String validImageURL = _imageURLController.value;

    for (IngredientAmountModel ia in chosenIngredients) {
      ia.recipeTitle = validTitle;
    }

    print(validTitle);
    print(recipeType);
    print(validPreperationText);
    print(validImageURL);
    print(chosenIngredients);

    // add new recipe to DB and return true if successfull/false if smth went wrong
    return repository.addRecipe(validTitle, recipeType, validPreperationText,
        validImageURL, chosenIngredients);
  }

  void dispose() {
    _titleController.close();
    _preperationTextController.close();
    _imageURLController.close();
  }
}

final ValidationBloc validationBloc = ValidationBloc();
