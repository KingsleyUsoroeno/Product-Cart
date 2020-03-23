import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String email;

  User({@required this.id, @required this.email});

  Map<String, dynamic> toJson() => {'id': id, 'email': email};

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'];

  @override
  String toString() {
    return 'User{id: $id, email: $email}';
  }
}
