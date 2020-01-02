import 'package:flutter/material.dart';
import 'package:flutter_course/productPojo.dart';

class ProductsList extends StatelessWidget {
  final List<ProductPojo> _products;
  final Function deleteProduct;

  ProductsList(this._products, {this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return _products != null && _products.length == 0
        ? Center(
            child: Text('Click the button to add a random cart to the list'),
          )
        : ListView.builder(
            itemCount: _products != null ? _products.length : 0,
            itemBuilder: (BuildContext context, int pos) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Image.asset(_products[pos].productImage),
                    Text(_products[pos].productName),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.pushNamed<bool>(
                                  context, "/products",
                                  arguments: _products[pos])
                              .then((bool value) {
                            if (value == false) {
                              return;
                            }
                            print(
                                "object being passed from onBack pressed is $value");
                            deleteProduct(pos);
                          }),
                          child: Text('View More'),
                        )
                      ],
                    )
                  ],
                ),
              );
            });
  }
}
