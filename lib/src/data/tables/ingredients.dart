import 'package:moor_flutter/moor_flutter.dart';

// part 'moor_database.g.dart';

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 70)();
  TextColumn get ingredientType => text().withLength(min: 1, max: 70)();
  DateTimeColumn get syncDate => dateTime().nullable()();
}
