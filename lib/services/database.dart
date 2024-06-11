import 'dart:async';
import 'dart:developer';

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
    const int currentVersion = 2;

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
    await db.update('tasks', task.toMap());
}

  Future<List<Task>> allTasks() async {
    final db = await database;

    final List<Map<String, Object?>> tasksMap = await db.query('tasks');

    return [
      for (final {
            'id': id as int,
            'title': title as String,
            'due_date': dueDate as String,
            'is_done': isDone as int
          } in tasksMap)
        Task(id: id, title: title, dueDate: dueDate, isDone: isDone == 1 ? true : false)
    ];
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
