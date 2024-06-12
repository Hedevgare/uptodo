import 'package:flutter/material.dart';
import 'package:uptodo/services/database.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  DatabaseService database = DatabaseService();

  TaskProvider() {
    getTasks();
  }

  Future<List<Task>> getTasks() async {
    return await database.allTasks();
  }

  Future<void> addTask(task) async {
    await database.insertTask(task);
    notifyListeners();
  }

  Future<void> updateTask(Task task) async {
    await database.updateTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await database.deleteTask(id);
    notifyListeners();
  }

  Future<void> purgeAllData() async {
    await database.deleteAllTasks();
    notifyListeners();
  }
}