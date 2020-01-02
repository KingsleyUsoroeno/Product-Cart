import 'package:flutter/material.dart';
import 'package:flutter_course/pages/home.dart';
import 'package:flutter_course/pages/my_products_page.dart';
import 'package:flutter_course/pages/product_create.dart';

class ManageProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(
            elevation: 8.0,
            child: Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  title: Text('Choose'),
                ),
                ListTile(
                  title: Text('All Products'),
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomePage())),
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Manage Products'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  text: 'Create Product',
                  icon: Icon(Icons.create),
                ),
                Tab(
                  text: 'My Products',
                  icon: Icon(Icons.list),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductCreatePage(),
              MyProductsPage(),
            ],
          ),
        ));
  }
}
