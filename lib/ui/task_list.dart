import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/providers/task_provider.dart';
import 'package:uptodo/ui/task_item_list.dart';

import '../models/task.dart';

class TaskList extends StatelessWidget {
  final bool isDone;
  final bool justToday;

  const TaskList({super.key, required this.isDone, required this.justToday});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
          return FutureBuilder<List<Task>>(
                future: taskProvider.getTasks(isDone, justToday),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nothing ${isDone ? 'done' : 'to do'}!'));
                  } else {
                    List<Task> t = snapshot.data ?? [];
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: t.length,
                        itemBuilder: (context, int index) {
                          return TaskItemList(
                              task: t[index],
                              onDelete: () => taskProvider.deleteTask(t[index].id!),
                              onUpdate: () => taskProvider.updateTask(t[index]));
                        });
                  }
                },
              );
      },
    );
  }
}
