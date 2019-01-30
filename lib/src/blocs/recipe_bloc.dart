import "package:rxdart/rxdart.dart";
import "../resources/repository.dart";

class RecipeBloc {
  final Repository repository = Repository();
  List<String> _recipeTypes;
  List<bool> _recipeTypeBools;

  /// should use streams and return items that way
  List<String> getIngredients() {
    return repository.getIngredients();
  }

  List<String> getRecipeTypes() {
    _recipeTypes = repository.getRecipeTypes();
    _recipeTypeBools = List<bool>(_recipeTypes.length);
    for (int i = 0; i < _recipeTypeBools.length; i++) {
      _recipeTypeBools[i] = false;
    }

    return _recipeTypes;
  }

  bool isSelectedRecipeType(int index) {
    print("in isSelectedRe ${_recipeTypeBools[index]}");
    return _recipeTypeBools[index];
  }

  void setSelectedRecipeType(int index, bool value) {
    _recipeTypeBools[index] = value;
  }
}
