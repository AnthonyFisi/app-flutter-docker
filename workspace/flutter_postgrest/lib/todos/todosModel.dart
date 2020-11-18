class todos {
  final int id;
  final bool done;
  final String task;
  final DateTime due;

  todos({this.id, this.done, this.task, this.due});

  factory todos.fromJson(Map<String, dynamic> json) {
    return todos(
        id: json['id'] as int,
        done: json['done'] as bool,
        task: json['task'] as String,
        due: json['due'] as DateTime);
  }
}
