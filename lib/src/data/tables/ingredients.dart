import 'package:moor/moor.dart';

class Ingredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 70)();
  TextColumn get ingredientType =>
      text().withLength(min: 1, max: 70).customConstraint(
          'REFERENCES ingredient_types(name) ON UPDATE CASCADE')();
  DateTimeColumn get syncDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id, name};

  @override
  List<String> get customConstraints => ['UNIQUE (name)'];
}
