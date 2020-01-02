import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product.dart';

class ProductsList extends StatelessWidget {
  final List<String> _products;
  final Function deleteProduct;

  ProductsList(this._products, {this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return _products.length == 0
        ? Center(
            child: Text('Click the button to add a random cart to the list'),
          )
        : ListView.builder(
            itemCount: _products.length,
            itemBuilder: (BuildContext context, int pos) {
              return Card(
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/food.jpg'),
                    Text(_products[pos]),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () => Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => ProductPage(
                                    _products[pos], 'assets/images/food.jpg'),
                              )).then((value) {
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
