import 'package:sqflite/sqflite.dart';

class MigrationsService {
  static void migrationV1(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS tasks;');
    batch.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, due_date TEXT);');
  }

  static void migrationV2(Batch batch) {
    batch.execute('DROP TABLE IF EXISTS tasks;');
    batch.execute(
        'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, due_date TEXT, is_done INTEGER);');
  }
}