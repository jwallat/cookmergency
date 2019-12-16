import 'package:moor/moor.dart';

// part 'moor_database.g.dart';

class IngredientTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 70)();
  DateTimeColumn get syncDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id, name};

  @override
  List<String> get customConstraints => ['UNIQUE (name)'];
}
