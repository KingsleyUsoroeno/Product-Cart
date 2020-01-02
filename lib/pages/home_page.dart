import 'package:flutter/material.dart';
import 'package:flutter_course/products_list.dart';

import '../productPojo.dart';

class HomePage extends StatelessWidget {
  final List<ProductPojo> products;
  final Function deleteProduct;

  HomePage(this.products, this.deleteProduct);

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
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, "/manageProduct"))
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('EasyList'),
          elevation: 9.0,
        ),
        body: ProductsList(
          products,
          deleteProduct: deleteProduct,
        ));
  }
}
