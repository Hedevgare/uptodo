import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/models/task.dart';
import 'package:uptodo/providers/task_provider.dart';
import 'package:uptodo/services/database.dart';
import 'package:uptodo/ui/task_item_list.dart';
import 'package:uptodo/ui/task_list.dart';
import 'package:uptodo/views/new_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService database = DatabaseService();

  Future<List<Task>> getTasks() async {
    var tasks = await database.allTasks();
    return tasks;
  }

  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = getTasks();
  }

  void updateTask(Task task) async {
    task.isDone = !task.isDone;
    await database.updateTask(task).then((r) => {
          setState(() {
            tasks = getTasks();
          })
        });
  }

  void deleteTask(int id) {
    database.deleteTask(id).then((r) => {
          setState(() {
            tasks = getTasks();
          })
        });
  }

  // Development purposes
  void purgeDatabase() {
    database.deleteAllTasks().then((r) => {
          setState(() {
            tasks = getTasks();
          })
        });
  }

  // End

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("TODO: App settings")));
                Provider.of<TaskProvider>(context, listen: false).purgeAllData();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // const TextField(
            //   decoration: InputDecoration(hintText: "Search tasks"),
            // ),
            Text(
              "My Tasks",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: TaskList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (context) => const NewTask()));
        },
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Future<void> navigateToNewTask(BuildContext context) async {
  //   await
  // }
}
