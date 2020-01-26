import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';
  bool _acceptTerms = false;

  Widget _buildEmailTextInput() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          labelText: 'Email', fillColor: Colors.white, filled: true),
      onChanged: (String val) {
        setState(() {
          _email = val;
        });
      },
    );
  }

  Widget _buildPasswordTextInput() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      textInputAction: TextInputAction.done,
      obscureText: true,
      onChanged: (String val) {
        setState(() {
          _password = val;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 : deviceWidth * 0.95;

    return Scaffold(
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
                        Colors.black12.withOpacity(0.3), BlendMode.dstATop))),

            padding: EdgeInsets.all(12.0),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  width: targetWidth,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextInput(),
                      SizedBox(height: 18.0,),
                      _buildPasswordTextInput(),
                      SwitchListTile(
                        value: _acceptTerms,
                        onChanged: (bool value) {
                          setState(() {
                            _acceptTerms = value;
                          });
                        },
                        title: Text('Accept Terms'),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        textColor: Colors.white,
                        color: Theme
                            .of(context)
                            .accentColor,
                        child: Text('Login'),
                        onPressed: () =>
                            Navigator.pushReplacementNamed(context, '/home'),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
