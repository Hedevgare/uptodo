import 'package:flutter/material.dart';
import 'package:uptodo/ui/task_item_list.dart';
import 'package:uptodo/views/new_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<TaskItemList> tasks = <TaskItemList>[
    const TaskItemList(title: "Task one"),
    const TaskItemList(title: "Task 2"),
    const TaskItemList(title: "Task number 3"),
  ];

  void addTask(String title) {
    setState(() {
      tasks.add(TaskItemList(title: title));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Settings pressed.")));
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
            Expanded(
              child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, int index) {
                    return tasks[index];
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // addTask("New task");
          navigateToNewTask(context);
        },
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> navigateToNewTask(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const NewTask()));

    if (!context.mounted) return;

    addTask(result);
  }
}
