import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/pages/create_or_edit_product_page.dart';
import 'package:flutter_course/scoped_models/product_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MyProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
            builder: (BuildContext context, Widget child, ProductModel model) {
              return ListView.builder(
                      itemCount: model.products.length != 0 ? model.products.length : 0,
                      itemBuilder: (BuildContext context, int position) {
                        return Dismissible(
                                key: Key(model.products[position].productName),
                                background: Container(
                                  color: Colors.deepPurpleAccent,
                                ),
                                onDismissed: (DismissDirection dismissDirection) {
                                  if (dismissDirection == DismissDirection.endToStart) {
                                    print("Swiped from end to Start");
                                    model.deleteProduct(position);
                                  } else if (dismissDirection == DismissDirection.startToEnd) {
                                    print("Swiped from start to end");
                                    model.deleteProduct(position);
                                  }
                                },
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(model.products[position].productName),
                                      leading: CircleAvatar(
                                        backgroundImage:
                                        AssetImage(model.products[position].productImage),
                                        radius: 30.0,
                                      ),
                                      subtitle: Text(model.products[position].productDesc),
                                      contentPadding: EdgeInsets.all(8.0),
                                      trailing:
                                      _buildIconButton(context, model.products[position]),
                                    ),
                                    Divider()
                                  ],
                                ));
                      });
            });
  }
}

Widget _buildIconButton(BuildContext context, ProductPoJo product) {
  return IconButton(
    icon: Icon(Icons.edit),
    onPressed: () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductCreateOrEditPage(
            productToEdit: product,
          );
        },
      ));
    },
  );
}
