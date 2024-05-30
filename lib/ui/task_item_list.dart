import 'package:flutter/material.dart';

class TaskItemList extends StatelessWidget {
  final String title;

  const TaskItemList({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(child: Text(title)),
              IconButton(
                  onPressed: () => {print("Task item list pressed")},
                  icon: const Icon(Icons.more_horiz))
            ],
          ),
        ),
      ),
    );
  }
}
