import 'package:flutter/material.dart';
import 'package:flutter_course/local/sharedpreferences.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

const TextStyle _textStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontFamily: 'SourceCode',
);

class OnBoardingScreen extends StatelessWidget {
  static const length = 3;
  final pageIndexNotifier = ValueNotifier<int>(0);

  PageViewIndicator _buildCircularIndicator() {
    return PageViewIndicator(
      pageIndexNotifier: pageIndexNotifier,
      length: length,
      normalBuilder: (animationController, index) =>
          Circle(
            size: 8.0,
            color: Colors.black87,
          ),
      highlightedBuilder: (animationController, index) =>
          ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.ease,
            ),
            child: Circle(
              size: 8.0,
              color: Colors.white,
            ),
          ),
    );
  }

  final List<Widget> pages = [FirstPage(), SecondPage(), ThirdPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: FractionalOffset.bottomCenter,
        children: <Widget>[
          PageView.builder(
            onPageChanged: (index) => pageIndexNotifier.value = index,
            itemCount: pages.length,
            itemBuilder: (context, int index) {
              return pages[index];
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildCircularIndicator(),
          )
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      color: Colors.green,
      child: Center(
        child: Text(
          'Thank you for taking out time to use it',
          style: _textStyle,
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  static final String hasOnBoarded = "has_on_boarded";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(color: Colors.deepPurple),
        Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Center(child: Text('Buy and Manage your projects all in one place', style: _textStyle)),
        ),
        GestureDetector(
          onTap: () {
            SharedPreferenceHelper.saveBoolean(hasOnBoarded, true);
            Navigator.pushReplacementNamed(context, '/register');
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
    );
  }
}
