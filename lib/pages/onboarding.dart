import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  final TextStyle _textStyle =
      TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'SourceCode');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('On Boarding'),
//      ),
      body: PageView(
        children: <Widget>[
          Container(
            color: Colors.purple,
            child: Center(
              child: Text(
                'Welcome to my App',
                style: _textStyle,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.green,
            child: Center(
              child: Text(
                'Thank you for taking out time to use it',
                style: _textStyle,
              ),
            ),
          ),
          Container(
              color: Colors.deepPurple,
              padding: EdgeInsets.only(bottom: 26.0, right: 26.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  child: Text(
                    'Get Started',
                    style: _textStyle,
                  ),
                  onTap: () => Navigator.pushReplacementNamed(context, '/auth'),
                ),
              )),
        ],
      ),
    );
  }
}
