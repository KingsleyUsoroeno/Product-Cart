import 'package:flutter/material.dart';
import 'package:flutter_course/local/sharedpreferences.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OnBoardingScreenState();
  }
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  // ignore: non_constant_identifier_names
  static final String _HAS_ON_BOARDED = "has_on_boarded";

  @override
  void initState() {
    hasUserOnBoarded();
    super.initState();
  }

  void hasUserOnBoarded() async {
    dynamic hasUserOnBoarded = await SharedPreferenceHelper.getBoolean(_HAS_ON_BOARDED);
    print("hasUserOnBoarded is $hasUserOnBoarded");
    if (hasUserOnBoarded == false) {
      print("These is the first time user has opened the App");
    } else if (hasUserOnBoarded == true) {
      Navigator.pushNamed(context, '/register');
      //Navigator.pop(context);
    }
  }

  final TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: 'SourceCode',
  );

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to my App',
                    style: _textStyle,
                  ),
                ],
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
          Stack(
            children: <Widget>[
              Container(color: Colors.deepPurple),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Center(child: Text('Buy and Manage your projects all in one place', style: _textStyle)),
              ),
              GestureDetector(
                onTap: () {
                  SharedPreferenceHelper.saveBoolean(_HAS_ON_BOARDED, true);
                  Navigator.pushNamed(context, '/register');
                  //Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0, right: 22.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
