import 'package:moor_flutter/moor_flutter.dart';

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 70)();
  TextColumn get recipeType => text()
      .withLength(min: 1, max: 70)
      .customConstraint('REFERENCES recipeTypes(name)')();
  TextColumn get preparationText => text().withLength(min: 1, max: 10000)();
  TextColumn get imageUrl => text().withLength(min: 1, max: 270)();
  TextColumn get preparationTime => text().withLength(min: 1, max: 70)();
  DateTimeColumn get syncDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id, title};
}
