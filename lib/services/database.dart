import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uptodo/models/task.dart';

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
    return openDatabase(join(await getDatabasesPath(), 'uptodo.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, due_date TEXT);');
    }, version: 1);
  }

  Future<void> insertTask(Task task) async {
    final db = await database;
    await db.insert('tasks', task.toMap());
  }

  Future<List<Task>> allTasks() async {
    final db = await database;

    final List<Map<String, Object?>> tasksMap = await db.query('tasks');

    return [
      for (final {
            'id': id as int,
            'title': title as String,
            'due_date': dueDate as String
          } in tasksMap)
        Task(id: id, title: title, dueDate: dueDate)
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
