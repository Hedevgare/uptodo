import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/providers/task_provider.dart';
import 'package:uptodo/ui/task_list.dart';
import 'package:uptodo/views/new_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("TODO: App settings")));
                // Provider.of<TaskProvider>(context, listen: false).purgeAllData();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Search tasks",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)))),
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Tasks",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const TaskList(
              isDone: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Completed",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const TaskList(
              isDone: true,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewTask()));
        },
        tooltip: 'New task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
