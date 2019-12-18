import 'package:cookmergency/src/data/moor_database.dart';
import "package:flutter/material.dart";
import 'package:moor_flutter/moor_flutter.dart';
import "src/app.dart";

AppDatabase db = AppDatabase(
  FlutterQueryExecutor.inDatabaseFolder(
      path: "db.sqlite", logStatements: false),
);
void main() => runApp(App());
