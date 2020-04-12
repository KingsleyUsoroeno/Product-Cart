import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_course/local/sharedpreferences.dart';
import 'package:flutter_course/models/user.dart';

class AuthProvider with ChangeNotifier {
  User _authenticatedUser;
  bool _isLoading = false;

  bool get loading => _isLoading;

  loadingState(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void login(String email, String password) {
    print("user email and password is email $email  and paasword is $password");
  }

  User _getUserFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(id: firebaseUser.uid, email: firebaseUser.email) : null;
  }

  Future registerUser(String email, String password) async {
    try {
      loadingState(true);
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      loadingState(false);
      return _getUserFromFirebaseUser(result.user);
    } catch (e) {
      print("Caught an exception registering user ${e.toString()}");
      loadingState(false);
      return null;
    }
  }

  Future loginUser(String email, String password) async {
    try {
      loadingState(true);
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      loadingState(false);
      return _getUserFromFirebaseUser(result.user);
    } catch (e) {
      print("Caught an exception registering user ${e.toString()}");
      loadingState(false);
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
