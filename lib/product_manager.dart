import 'package:flutter/material.dart';
import 'package:flutter_course/product.dart';
import 'package:flutter_course/product_control.dart';

class ProductManager extends StatefulWidget {
  final String _startingProduct;

  ProductManager(this._startingProduct);

  @override
  State<StatefulWidget> createState() {
    return new ProductManagerState();
  }
}

class ProductManagerState extends State<ProductManager> {
  final List<String> _products = [];

  void _addProduct(String product) {
    setState(() {
      _products.add(product);
    });
  }

  void _deleteProduct(int position) {
    setState(() {
      _products.removeAt(position);
    });
  }

  @override
  void initState() {
    _products.add(widget._startingProduct); // Food Tester
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10.0), child: ProductControl(_addProduct)),
          Expanded(
            child: ProductsList(_products, deleteProduct: _deleteProduct),
          )
        ],
      ),
    );
  }
}
