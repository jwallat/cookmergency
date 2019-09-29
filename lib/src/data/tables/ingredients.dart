import 'package:moor_flutter/moor_flutter.dart';

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 70)();
  TextColumn get ingredientType => text()
      .withLength(min: 1, max: 70)
      .customConstraint('REFERENCES ingredientTypes(name)')();
  DateTimeColumn get syncDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id, name};
}
