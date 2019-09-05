import 'package:moor_flutter/moor_flutter.dart';

// part 'moor_database.g.dart';

class IngredientAmounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ingredientName => text().withLength(min: 1, max: 70)();
  TextColumn get recipeTitle => text().withLength(min: 1, max: 70)();
  IntColumn get amount => integer()();
  TextColumn get amountUnit => text().withLength(min: 1, max: 20)();
  DateTimeColumn get syncDate => dateTime().nullable()();
}
