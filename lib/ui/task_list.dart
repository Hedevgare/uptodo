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
          return FutureBuilder<List<Task>>(
                future: taskProvider.getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Nothing to do!'));
                  } else {
                    List<Task> t = snapshot.data ?? [];
                    return ListView.builder(
                        itemCount: t.length,
                        itemBuilder: (context, int index) {
                          return TaskItemList(
                              task: t[index],
                              onDelete: () => taskProvider.deleteTask(t[index].id!),
                              onUpdate: () => taskProvider.updateTask(toggleTask(t[index])));
                        });
                  }
                },
              );
      },
    );
  }
}