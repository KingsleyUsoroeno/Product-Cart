import 'package:flutter/material.dart';
import 'package:flutter_course/screens/my_products_screen.dart';

import 'create_product_screen.dart';

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
                Container(
                  height: 200.0,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/profile_img.png'),
                          maxRadius: 60.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Kingsley Usoro',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                    leading: Icon(
                      Icons.shop,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('All Products'),
                    onTap: () => Navigator.pushReplacementNamed(context, "/home"))
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
              CreateProduct(),
              MyProductsPage(),
            ],
          ),
        ));
  }
}
