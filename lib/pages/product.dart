import 'package:flutter/material.dart';
import 'package:flutter_course/productPojo.dart';

class ProductPage extends StatelessWidget {
  final ProductPojo _product;

  ProductPage(this._product);

  void _showWarningDialog(BuildContext context) {
    showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Are you sure'),
                content: Text('These Action cannot be undone'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('DELETE'),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    },
                  ),
                  FlatButton(
                          child: Text('DISMISS'),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                ],
              );
            });
  }

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
            title: Text(_product.productName),
          ),
          body: Column(
            children: <Widget>[
              Image.asset(_product.productImage),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Text(_product.productDesc),
              ),
              RaisedButton(
                onPressed: () => _showWarningDialog(context),
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
