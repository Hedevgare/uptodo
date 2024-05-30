class Task {
  final int? id;
  final String title;

  const Task({this.id, required this.title});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
