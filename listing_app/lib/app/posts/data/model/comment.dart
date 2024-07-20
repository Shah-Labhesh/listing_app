import 'dart:convert';

class Comment {
  int? id;
  int? postId;
  String? name;
  String? email;
  String? body;
  Comment({
    this.id,
    this.postId,
    this.name,
    this.email,
    this.body,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'postId': postId,
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] != null ? map['id'] as int : null,
      postId: map['postId'] != null ? map['postId'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      body: map['body'] != null ? map['body'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);
}
