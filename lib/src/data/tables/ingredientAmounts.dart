import 'package:moor/moor.dart';

class IngredientAmounts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get ingredientName => text()
      .withLength(min: 1, max: 70)
      .customConstraint('REFERENCES ingredients(name)')();
  TextColumn get recipeTitle => text()
      .withLength(min: 1, max: 70)
      .customConstraint('REFERENCES recipes(title)')();
  IntColumn get amount => integer()();
  TextColumn get amountUnit => text().withLength(min: 1, max: 20)();
  DateTimeColumn get syncDate => dateTime().nullable()();
}
