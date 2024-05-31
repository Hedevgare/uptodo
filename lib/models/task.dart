class Task {
  final int? id;
  final String title;
  final String? dueDate;

  const Task({this.id, required this.title, this.dueDate});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'due_date': dueDate.toString().split(' ')[0],
    };
  }
}
