import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<StatefulWidget> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
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
      appBar: AppBar(title: const Text("New task")),
      body: Column(
        children: [
          Center(
            child: SizedBox(
              width: 250,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "New task text", border: OutlineInputBorder()),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: const Text("Add"))
        ],
      ),
    );
  }
}
