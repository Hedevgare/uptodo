import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/models/task.dart';

class TaskItemList extends StatelessWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const TaskItemList({super.key, required this.task, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: task.isDone ? Colors.lightGreen[200] : Colors.white,
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(task.title, style: const TextStyle(fontSize: 16)),
                    Text(
                      task.dueDate == 'null'
                          ? ''
                          : DateFormat.yMMMEd()
                              .format(DateTime.parse(task.dueDate!)),
                      style:
                          const TextStyle(color: Colors.blueGrey, fontSize: 12),
                    )
                  ])),
              IconButton(
                  onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.delete,
                                      color: Colors.red),
                                  title: const Text(
                                    'Delete task',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: () {
                                    onDelete();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.check),
                                  title: Text('Mark as ${task.isDone ? "not done" : "done"}'),
                                  onTap: () {
                                    onUpdate();
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                  icon: const Icon(Icons.more_horiz)),
            ],
          ),
        ),
      ),
    );
  }
}
