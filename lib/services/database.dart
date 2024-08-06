import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uptodo/models/task.dart';
import 'package:uptodo/services/migrations.dart';

class DatabaseService {
  DatabaseService._privateConstructor();

  static final DatabaseService instance = DatabaseService._privateConstructor();

  factory DatabaseService() {
    return instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  initDatabase() async {
    final path = join(await getDatabasesPath(), 'uptodo.db');
    const int currentVersion = 3;

    return openDatabase(path, version: currentVersion, onCreate: (db, version) async {
      var batch = db.batch();
      MigrationsService.migrationV1(batch);
      await batch.commit();
    }, onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      switch(oldVersion) {
        case 1:
          MigrationsService.migrationV2(batch);
          break;
        case 2:
          MigrationsService.migrationV3(batch);
          break;
      }
      await batch.commit();
    }, onDowngrade: onDatabaseDowngradeDelete);
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
}

  Future<List<Task>> allTasks(bool isDone, bool justToday) async {
    String beginOfDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString().split(" ")[0];
    final db = await database;
    String whereClause = justToday ? 'is_done = ? AND done_date = ?' : 'is_done = ?';
    List<Object> whereArgs = justToday ? [isDone ? 1 : 0, beginOfDay] : [isDone ? 1 : 0];
    final List<Map<String, Object?>> tasksMap = await db.query('tasks', where: whereClause, whereArgs: whereArgs, orderBy: 'due_date ASC');
    return tasksMap.map((map) => Task.fromMap(map)).toList();
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  // For development purposes
  Future<void> deleteAllTasks() async {
    final db = await database;

    await db.execute('DELETE FROM tasks');
  }

  Future<void> deleteDatabase(String path) =>
      databaseFactory.deleteDatabase(path);
}
