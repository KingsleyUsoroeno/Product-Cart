import 'package:flutter/material.dart';
import 'package:flutter_course/pages/manage_products.dart';

import '../product_manager.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          elevation: 8.0,
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text('Choose'),
              ),
              ListTile(
                title: Text('Manage Products'),
                onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ManageProductPage())),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('EasyList'),
          elevation: 9.0,
        ),
        body: Column(
          children: <Widget>[
            ProductManager("Food Tester"),
          ],
        ));
  }
}
