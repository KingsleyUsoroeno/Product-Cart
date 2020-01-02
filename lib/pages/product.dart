import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String _title;
  final String _imageUrl;

  ProductPage(this._title, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print("Back Button Pressed");
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(_title),
          ),
          body: Column(
            children: <Widget>[
              Image.asset(_imageUrl),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(_title),
              ),
              RaisedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Delete'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                elevation: 8.0,
              )
            ],
          ),
        ));
  }
}
