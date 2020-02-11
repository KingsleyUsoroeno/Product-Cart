import 'package:flutter_course/models/user.dart';

class UserModel {
  User _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = User(id: "mommy", email: email, password: password);
    print("authenticated user is $_authenticatedUser");
  }

  User get getAuthenticatedUser {
    if (_authenticatedUser != null) {
      return _authenticatedUser;
    } else {
      return User(id: "", email: "", password: "");
    }
  }
}
