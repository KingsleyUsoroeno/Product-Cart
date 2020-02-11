import 'package:flutter/cupertino.dart';

class User {
  final String id;
  final String email;
  final String password;

  User({@required this.id, @required this.email, @required this.password});

  @override
  String toString() {
    return 'User{id: $id, email: $email, password: $password}';
  }
}
