import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/local/sharedpreferences.dart';
import 'package:flutter_course/models/user.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider with ChangeNotifier {
  User _authenticatedUser;

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  setState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _getUserFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(id: firebaseUser.uid, email: firebaseUser.email) : null;
  }

  Future registerUser(String email, String password) async {
    try {
      setState(ViewState.Busy);
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      setState(ViewState.Idle);
      return _getUserFromFirebaseUser(result.user);
    } catch (e) {
      showToast("login failed due to ${e.toString()}");
      print("Caught an exception registering user ${e.toString()}");
      setState(ViewState.Idle);
      return null;
    }
  }

  Future loginUser(String email, String password) async {
    try {
      setState(ViewState.Busy);
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      setState(ViewState.Idle);
      return _getUserFromFirebaseUser(result.user);
    } catch (e) {
      showToast("login failed due to ${e.toString()}");
      print("Caught an exception registering user ${e.toString()}");
      setState(ViewState.Idle);
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

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
