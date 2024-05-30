import 'package:flutter/material.dart';

class TaskItemList extends StatelessWidget {
  final String title;

  const TaskItemList({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title)
    );
  }
}
