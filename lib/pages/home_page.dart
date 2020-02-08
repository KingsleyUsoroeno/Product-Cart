import 'package:flutter/material.dart';
import 'package:flutter_course/widget/product/products_list.dart';

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
                      leading: Icon(
                          Icons.edit,
                          color: Theme
                                  .of(context)
                                  .primaryColor,
                          size: 26.0,
                      ),
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, "/manageProduct"))
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('EasyList'),
          elevation: 9.0,
            actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.favorite),
                    onPressed: () {
                    },
                )
            ],
        ),
            body: ProductsList());
  }
}
