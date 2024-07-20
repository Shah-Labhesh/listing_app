import 'dart:convert';

class Todo {
  int? id;
  String? title;
  int? userId;
  bool? completed;
  Todo({
    this.id,
    this.title,
    this.userId,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'userId': userId,
      'completed': completed,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      completed: map['completed'] != null ? map['completed'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
