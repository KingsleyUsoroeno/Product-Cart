import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/scoped_models/AppModel.dart';
import 'package:flutter_course/screens/edit_product_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class MyProductsPage extends StatefulWidget {
  final AppModel appModel;

  MyProductsPage({this.appModel});

  @override
  State<StatefulWidget> createState() {
    return MyProductsPageState();
  }
}

class MyProductsPageState extends State<MyProductsPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(builder: (BuildContext context, Widget child, AppModel model) {
      return FutureBuilder(
        future: model.fetchProductsFromFirebase(),
        builder: (context, AsyncSnapshot<List<ProductPoJo>> asyncSnapShot) {
          if (asyncSnapShot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (asyncSnapShot.hasError) {
            return Center(child: Text("Failed to load Data"));
          } else {
            return ListView.builder(
                itemCount: asyncSnapShot.data.length,
                itemBuilder: (BuildContext context, int position) {
                  ProductPoJo product = asyncSnapShot.data[position];
                  return Dismissible(
                      key: Key(product.productName),
                      background: Container(
                        color: Colors.deepPurpleAccent,
                      ),
                      onDismissed: (DismissDirection dismissDirection) {
                        if (dismissDirection == DismissDirection.endToStart) {
                          print("Swiped from end to Start");
                          model.setSelectedProductIndex(position);
                          model.deleteProduct();
                        } else if (dismissDirection == DismissDirection.startToEnd) {
                          print("Swiped from start to end");
                          model.deleteProduct();
                        }
                      },
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(product.productName),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(product.productImage),
                              radius: 30.0,
                            ),
                            subtitle: Text(product.productDesc),
                            contentPadding: EdgeInsets.all(8.0),
                            trailing: _buildIconButton(context, model, product, position),
                          ),
                          Divider()
                        ],
                      ));
                });
          }
        },
      );
    });
  }
}

Widget _buildIconButton(BuildContext context, AppModel appModel, ProductPoJo product, int selectedIndex) {
  return IconButton(
    icon: Icon(Icons.edit),
    onPressed: () {
      appModel.setSelectedProductIndex(selectedIndex);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return EditProduct(
            productToEdit: product,
          );
        },
      ));
    },
  );
}
