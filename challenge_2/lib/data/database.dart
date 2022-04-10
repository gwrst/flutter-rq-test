import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class MyTimes extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get timestamp => integer()();
}

@DriftDatabase(tables: [MyTimes])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<List<MyTime>> watchEntries() => select(myTimes).watch();

  Future<int> addMyTime(int timestamp) {
    return into(myTimes).insert(
      MyTimesCompanion.insert(timestamp: timestamp),
    );
  }

  Future<int> deleteMyTime(int id) {
    return (delete(myTimes)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    },
  );
}
