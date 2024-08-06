import 'package:flutter/material.dart';
import 'package:uptodo/services/database.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  final DatabaseService database = DatabaseService();

  TaskProvider();

  Future<List<Task>> getTasks(bool isDone, bool justToday) async {
    return await database.allTasks(isDone, justToday);
  }

  Future<void> addTask(task) async {
    await database.insertTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    task.doneDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1).toString();
    await database.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await database.deleteTask(id);
    notifyListeners();
  }

  // Development purposes
  Future<void> purgeAllData() async {
    await database.deleteAllTasks();
    notifyListeners();
  }
}
