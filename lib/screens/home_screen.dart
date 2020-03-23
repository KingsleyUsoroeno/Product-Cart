import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/scoped_models/AppModel.dart';
import 'package:flutter_course/widget/product/products_list.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel productModel) {
        return Scaffold(
            drawer: Drawer(
              elevation: 8.0,
              child: Column(
                children: <Widget>[
                  AppBar(
                    automaticallyImplyLeading: false,
                    title: Text('My Profile'),
                    centerTitle: true,
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
                      title: Text('Manage Products'),
                      leading: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 20.0,
                      ),
                      onTap: () => Navigator.pushReplacementNamed(context, "/manageProduct")),
                  Divider(),
                  ListTile(
                    title: Text('Log out'),
                    leading: Icon(
                      Icons.edit,
                      color: Theme.of(context).primaryColor,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              title: Text('EasyList'),
              elevation: 9.0,
              actions: <Widget>[
                IconButton(
                  icon: Icon(productModel.favourites ? Icons.favorite : Icons.favorite_border),
                  onPressed: () {
                    productModel.toggleFavouriteMode();
                  },
                )
              ],
            ),
            body: FutureBuilder(
              future: productModel.fetchProductsFromFirebase(),
              builder: (context, AsyncSnapshot<List<ProductPoJo>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Failed to fetch products, pls try again '),
                  );
                } else {
                  return ProductsList(
                    products: snapshot.data,
                  );
                }
              },
            ));
      },
    );
  }
}
