import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_course/local/sharedpreferences.dart';
import 'package:flutter_course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

mixin UserModel on Model {
  User _authenticatedUser;
  bool _isLoading = false;

  bool getLoading() {
    return _isLoading;
  }

  void loadingState(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void login(String email, String password) {
    print("user email and password is email $email  and paasword is $password");
  }

  User _getUserFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null
        ? User(id: firebaseUser.uid, email: firebaseUser.email)
        : null;
  }

  Future registerUser(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _getUserFromFirebaseUser(result.user);
    } catch (e) {
      print("Caught an exception registering user ${e.toString()}");
      return null;
    }
  }

  Future<User> getCurrentUser(String key) async {
    String userString = await SharedPreferenceHelper.getString(key);
    if (userString.isEmpty) {
      return null;
    }
    User user = User.fromJson(jsonDecode(userString));
    print("User is $user");
    return user;
  }

  User get getAuthenticatedUser {
    if (_authenticatedUser != null) {
      return _authenticatedUser;
    } else {
      return User(id: "", email: "");
    }
  }
}
