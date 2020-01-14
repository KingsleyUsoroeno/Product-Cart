import 'package:flutter/material.dart';
import 'package:flutter_course/productPojo.dart';
import 'package:flutter_course/widget/price_tag.dart';

class ProductsList extends StatelessWidget {
  final List<ProductPojo> _products;
  final Function deleteProduct;

  ProductsList(this._products, {this.deleteProduct});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _products != null ? _products.length : 0,
        itemBuilder: (BuildContext context, int pos) {
          return Card(
            child: Column(
              children: <Widget>[
                /*Our Product Image*/
                Image.asset(_products[pos].productImage),
                Container(
                    margin: EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /*Our ProductName*/
                        Text(
                          _products[pos].productName,
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SourceCode'),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        /*Our Product Price Tag widget*/
                        PriceTag(_products[pos].productPrice.toString()),
                      ],
                    )),
                /** Location textView*/
                Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text('These is going to be the location'),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
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
                      color: Theme.of(context).primaryColor,
                      icon: Icon(Icons.info),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_border),
                      color: Colors.red,
                      onPressed: () => print('I was pressed suckers'),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
