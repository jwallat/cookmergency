import "package:rxdart/rxdart.dart";
import "../resources/repository.dart";

class RecipeBloc {
  final Repository repository = Repository();

  /// should use streams and return items that way
  List<String> getIngredients() {
    return repository.getIngredients();
  }

  List<String> getRecipeTypes() {
    return repository.getRecipeTypes();
  }
}
