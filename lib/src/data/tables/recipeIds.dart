import 'package:moor/moor.dart';

class RecipeIds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get remoteId =>
      integer().nullable()(); //.customConstraint('UNIQUE remoteId')();
  IntColumn get localId =>
      integer().customConstraint('REFERENCES recipes(id)').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<String> get customConstraints => ['UNIQUE (remote_Id, local_id)'];
}
