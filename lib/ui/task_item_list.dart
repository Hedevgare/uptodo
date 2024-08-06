import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uptodo/models/task.dart';

class TaskItemList extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

  const TaskItemList(
      {super.key,
      required this.task,
      required this.onDelete,
      required this.onUpdate});

  @override
  State<TaskItemList> createState() => _TaskItemListState();
}

class _TaskItemListState extends State<TaskItemList> {
  late Task task;

  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  void updateTask(Task updatedTask) {
    setState(() {
      task = updatedTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            color: task.isDone ? const Color.fromRGBO(30, 30, 30, 1) : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(task.title, style: TextStyle(fontSize: 16, color: task.isDone ? Colors.grey[700] : Colors.white),),
                    Text(
                      task.dueDate == 'null'
                          ? ''
                          : DateFormat.yMMMEd()
                              .format(DateTime.parse(task.dueDate!)),
                      style:
                          TextStyle(color: task.isDone ? Colors.grey[700] : Colors.blueGrey[200], fontSize: 12),
                    )
                  ])),
              IconButton(
                  onPressed: () => showModalBottomSheet(
                        context: context,
                        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
                        builder: (BuildContext context) {
                          return Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.check, color: Colors.white),
                                  title: Text(
                                      'Mark as ${task.isDone ? "not done" : "done"}', style: const TextStyle(color: Colors.white),),
                                  onTap: () {
                                    task.isDone = !task.isDone;
                                    task.doneDate = task.isDone ? DateTime.now().toString() : 'null';
                                    updateTask(task);
                                    widget.onUpdate();
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.delete,
                                      color: Colors.red),
                                  title: const Text(
                                    'Delete task',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onTap: () {
                                    widget.onDelete();
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  icon: Icon(Icons.more_horiz, color: task.isDone ? Colors.grey[700] : Colors.white,)),
            ],
          ),
        ),
      ),
    );
  }
}
