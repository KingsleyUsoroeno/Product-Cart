import 'package:flutter/material.dart';
import 'package:flutter_course/pages/create_or_edit_product_page.dart';
import 'package:flutter_course/scoped_models/AppModel.dart';
import 'package:flutter_course/scoped_models/product_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, AppModel model) {
              return ListView.builder(
                      itemCount:
                      model.getProducts.length != 0 ? model.getProducts.length : 0,
                      itemBuilder: (BuildContext context, int position) {
                        return Dismissible(
                                key: Key(model.getProducts[position].productName),
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
                                      title: Text(model.getProducts[position].productName),
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                                model.getProducts[position].productImage),
                                        radius: 30.0,
                                      ),
                                      subtitle: Text(model.getProducts[position].productDesc),
                                      contentPadding: EdgeInsets.all(8.0),
                                      trailing: _buildIconButton(context, model, position),
                                    ),
                                    Divider()
                                  ],
                                ));
                      });
            });
  }
}

Widget _buildIconButton(BuildContext context, ProductModel productModel, int productIndex) {
  return IconButton(
    icon: Icon(Icons.edit),
    onPressed: () {
      productModel.setSelectedProductIndex(productIndex);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductCreateOrEditPage(
            productToEdit: productModel.getProducts[productIndex],
          );
        },
      ));
    },
  );
}
