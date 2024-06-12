import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/providers/task_provider.dart';

import '../models/task.dart';
import '../services/database.dart';

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

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final DatabaseService database = DatabaseService();

  Future<void> addTask(String title, String dueDate) async {
    Provider.of<TaskProvider>(context, listen: false).addTask(Task(title: title, dueDate: dueDate, isDone: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New task"),
        actions: [
          ChangeNotifierProvider(
            create: (context) => TaskProvider(),
            child: IconButton(
                onPressed: () => {
                      if (controller.text != "")
                        {
                          addTask(controller.text, selectedDate.toString())
                              .then((r) => Navigator.pop(context))
                        }
                    },
                icon: const Icon(Icons.check)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 5,
              controller: controller,
              decoration: const InputDecoration(
                  hintText: "Describe your task",
                  hintStyle: TextStyle(color: Colors.grey),
                  alignLabelWithHint: true,
                  labelText: "Task description",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
              onTapOutside: (e) => FocusScope.of(context).unfocus(),
            ),
            const SizedBox(height: 20.0),
            const Divider(),
            const SizedBox(height: 20.0),
            const Text(
              "Due date:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(selectedDate == null
                        ? 'No due date'
                        : DateFormat.yMMMEd().format(selectedDate!))),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Icon(Icons.calendar_month),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
