import 'package:flutter/material.dart';
import 'package:uptodo/services/database.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseService database = DatabaseService();

  List<Task> tasks = [];

  TaskProvider() {
    getTasks();
  }

  Future<void> getTasks() async {
    final list = await database.allTasks();
    tasks = [];
    notifyListeners();
    tasks = List.from(list);
    notifyListeners();
  }

  Future<void> addTask(task) async {
    await database.insertTask(task);
    await getTasks();
  }

  Future<void> updateTask(Task task) async {
    await database.updateTask(task);
    await getTasks();
  }

  Future<void> deleteTask(int id) async {
    await database.deleteTask(id);
    await getTasks();
  }
}