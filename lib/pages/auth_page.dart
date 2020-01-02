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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              title: Text('Login'),
            ),
            body: Container(
              padding: EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    onChanged: (String val) {
                      setState(() {
                        _email = val;
                      });
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Password'),
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    onChanged: (String val) {
                      setState(() {
                        _password = val;
                      });
                    },
                  ),
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
                    onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
                  )
                ],
              ),
            ));
  }
}
