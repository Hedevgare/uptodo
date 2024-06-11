class Task {
  final int? id;
  String title;
  String? dueDate;
  bool isDone;

  Task({this.id, required this.title, this.dueDate, required this.isDone});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'due_date': dueDate.toString().split(' ')[0],
      'is_done': isDone ? 1 : 0
    };
  }

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      dueDate: map['due_date'],
      isDone: map['is_done'] == 1,
    );
  }
}
