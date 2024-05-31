import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskItemList extends StatelessWidget {
  final String title;
  final String dueDate;

  const TaskItemList({super.key, required this.title, required this.dueDate});

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
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(title), Text(dueDate == 'null' ? '' : DateFormat.yMMMEd().format(DateTime.parse(dueDate)))]
              )),
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
