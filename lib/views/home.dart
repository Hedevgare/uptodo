import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uptodo/models/task.dart';
import 'package:uptodo/services/database.dart';
import 'package:uptodo/ui/task_item_list.dart';
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
    return await database.allTasks();
  }

  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = getTasks();
  }

  void addTask(String title) {
    database.insertTask(Task(title: title)).then((r) => {
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
                // purgeDatabase();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // const TextField(
            //   decoration: InputDecoration(hintText: "Search tasks"),
            // ),
            const Text(
              "My Tasks",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: tasks,
                builder: (context, snapshot) {
                  List<Task> t = snapshot.data ?? [];
                  if (t.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [Text("Nothing to do")]),
                    );
                  }
                  return ListView.builder(
                      itemCount: t.length,
                      itemBuilder: (context, int index) {
                        return TaskItemList(task: t[index], onDelete: () => deleteTask(t[index].id!),);
                      });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToNewTask(context);
        },
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> navigateToNewTask(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewTask()));

    if (!context.mounted) return;

    setState(() {
      tasks = getTasks();
    });
  }
}
