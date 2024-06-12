import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/providers/task_provider.dart';
import 'package:uptodo/ui/task_item_list.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});
  
  Task toggleTask(Task task) {
    task.isDone = !task.isDone;
    return task;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        if (taskProvider.tasks.isEmpty) {
          return const Center(child: Text("Nothing to do"));
        } else {
          return ListView.builder(itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskItemList(task: task, onDelete: () => taskProvider.deleteTask(task.id!), onUpdate: () => taskProvider.updateTask(toggleTask(task)));
              });
        }
      },
    );
  }
}
