import "dart:async";
import "package:rxdart/rxdart.dart";
import "validators.dart";

class ValidationBloc with Validators {
  final BehaviorSubject<String> _titleController = BehaviorSubject<String>();
  final BehaviorSubject<String> _recipeTypeController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _preperationTextController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _imageURLController = BehaviorSubject<String>();
  final BehaviorSubject<List<String>> _ingredientsController =
      BehaviorSubject<List<String>>();

  // Add data to stream
  Function(String) get changeTitle => _titleController.sink.add;
  Function(String) get changeRecipeType => _recipeTypeController.sink.add;
  Function(String) get changePreperationText =>
      _preperationTextController.sink.add;
  Function(String) get changeImageURL => _imageURLController.sink.add;
  Function(List<String>) get changeIngredients =>
      _ingredientsController.sink.add;

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

  // Stream<bool> get submitValid => Observable.combineLatest5(
  //       title,
  //       recipeType,
  //       preperationText,
  //       imageURL,
  //       ingredients,
  //       (dynamic title, dynamic recipeType, dynamic preperationText,
  //               dynamic imageURL, dynamic ingredients) =>
  //           true,
  //     );

  Stream<bool> get submitValid => Observable.combineLatest4(
        title,
        recipeType,
        preperationText,
        imageURL,
        (dynamic title, dynamic recipeType, dynamic preperationText,
                dynamic imageURL) =>
            true,
      );

  void submit() {
    final String validTitle = _titleController.value;
    final String validRecipeTitle = _recipeTypeController.value;
    final String validPreperationText = _preperationTextController.value;
    final String validImageURL = _imageURLController.value;
    final List<String> validIngredients = _ingredientsController.value;

    print(validTitle);
    print(validRecipeTitle);
    print(validPreperationText);
    print(validImageURL);
    print(validIngredients);
  }

  void dispose() {
    _titleController.close();
    _recipeTypeController.close();
    _preperationTextController.close();
    _imageURLController.close();
    _ingredientsController.close();
  }
}

final ValidationBloc validationBloc = ValidationBloc();
