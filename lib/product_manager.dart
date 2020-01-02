import 'package:flutter/material.dart';
import 'package:flutter_course/productPojo.dart';
import 'package:flutter_course/products_list.dart';

class ProductManager extends StatelessWidget {
    final Function _deleteProduct;
    final List<ProductPojo> _products;

    ProductManager(this._products, this._deleteProduct);

  @override
  Widget build(BuildContext context) {
      return ProductsList(_products, deleteProduct: _deleteProduct);
  }
}
