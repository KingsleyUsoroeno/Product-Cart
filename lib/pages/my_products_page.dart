import 'package:flutter/material.dart';
import 'package:flutter_course/pages/create_or_edit_product_page.dart';
import 'package:flutter_course/productPojo.dart';

class MyProductsPage extends StatelessWidget {
  final List<ProductPojo> products;
  final Function updateProduct;

  MyProductsPage({this.products, this.updateProduct});

  @override
  Widget build(BuildContext context) {
    return _buildProductListView(products, updateProduct);
  }
}

Widget _buildProductListView(List<ProductPojo> products,
    Function updateProduct) {
  return ListView.builder(
      itemCount: products.length != 0 ? products.length : 0,
      itemBuilder: (BuildContext context, int position) {
        return ListTile(
          title: Text(products[position].productName),
          leading: CircleAvatar(
            backgroundImage: AssetImage(products[position].productImage),
            radius: 30.0,),
          subtitle: Text(products[position].productDesc),
          contentPadding: EdgeInsets.all(8.0),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductCreateOrEditPage(
                      product: products[position],
                      updateProduct: updateProduct, productIndex: position);
                },
              ));
            },
          ),
        );
      });
}
