import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course/local/sharedpreferences.dart';
import 'package:flutter_course/models/user.dart';
import 'package:flutter_course/scoped_models/AppModel.dart';
import 'package:flutter_course/scoped_models/user_model.dart';
import 'package:flutter_course/widget/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scoped_model/scoped_model.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

// TODO Implement a Default Login feature whereBy the email and password field should never be null
// TODO And the Terms and Conditions Switch should always be accepted
class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;
  static String USER = "user";

  final Map<String, dynamic> _formData = {
    "email": "",
    "password": "",
    "acceptTerms": false
  };

  // change to textFormField
  Widget _buildEmailTextInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email', fillColor: Colors.white, filled: true),
      onSaved: (String email) {
        _formData["email"] = email;
      },
      // ignore: missing_return
      validator: (String email) {
        // validates whether these email field is empty or is a valid email
        if (email
            .trim()
            .isEmpty) {
          return "Email must be required ";
        } else if (!RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(email)) {
          return "This is not a valid email";
        }
      },
    );
  }

  Widget _buildPasswordTextInput() {
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      textInputAction: TextInputAction.done,
      obscureText: true,
      onSaved: (String password) {
        _formData["password"] = password;
      },
      // ignore: missing_return
      validator: (String password) {
        if (password
            .trim()
            .isEmpty) {
          return "Password is required ";
        } else if (password.length < 6) {
          return "Password is too short";
        }
      },
    );
  }

  registerUser(UserModel userModel) async {
    if (_formKey.currentState.validate()) {
      print("Validating user input");
      if (_formData["acceptTerms"] == false) {
        showToast("Please Accept terms and Conditions to Register");
        print("User didnt accept terms and conditions");
        return;
      }
      _formKey.currentState.save();
      String email = _formData['email'];
      String password = _formData['password'];
      print("form data after inputed values are $_formData");
      userModel.loadingState(true);
      dynamic result = await userModel.registerUser(email, password);
      // loading state
      if (result == null) {
        // registration was not successful
        userModel.loadingState(false);
        showToast("Registration failed, check and try again");
        return;
      }
      userModel.loadingState(false);
      // Save user response to SharedPreferences
      String encodedUser = jsonEncode(result);
      SharedPreferenceHelper.saveString(USER, encodedUser);
      print("user is $result");
      Navigator.pushReplacementNamed(context, '/home');
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

  void getCurrentUser() async {
    String userString = await SharedPreferenceHelper.getString(USER);
    if (userString.isEmpty) {
      return;
    }
    User user = User.fromJson(jsonDecode(userString));
    print("User is $user");
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ScopedModel.of<AppModel>(context, rebuildOnChange: true);

    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    return userModel.getLoading()
        ? LoadingSpinner()
        : Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          /*Background image/cover for our Auth page*/
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background_image.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black12.withOpacity(0.3),
                        BlendMode.dstATop))),
            padding: EdgeInsets.all(12.0),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                    width: targetWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        _buildEmailTextInput(),
                        SizedBox(
                          height: 18.0,
                        ),
                        _buildPasswordTextInput(),
                        SwitchListTile(
                          value: _acceptTerms,
                          onChanged: (bool value) {
                            setState(() {
                              _acceptTerms = value;
                              _formData["acceptTerms"] = value;
                            });
                          },
                          title: Text('Accept Terms'),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                              textColor: Colors.white,
                              color: Theme
                                  .of(context)
                                  .accentColor,
                              child: Text('Register'),
                              onPressed: () => registerUser(userModel),
                            )),
                      ]),
                    )),
              ),
            )));
  }
}
