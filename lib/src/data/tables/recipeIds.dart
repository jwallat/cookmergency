import 'package:moor_flutter/moor_flutter.dart';

class RecipeIds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId => integer().customConstraint('UNIQUE remoteId')();
  IntColumn get localId =>
      integer().customConstraint('REFERENCES recipes(id)').nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
