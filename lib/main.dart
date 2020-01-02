import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:flutter_course/pages/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //final List<String> _products = ["Food Tester", "Food Engineer"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.deepPurpleAccent),
        routes: {
          '/home': (BuildContext context) => HomePage(),
        },
        home: AuthPage());
  }
}
