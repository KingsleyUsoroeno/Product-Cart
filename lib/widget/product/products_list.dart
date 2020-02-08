import 'package:flutter/material.dart';
import 'package:flutter_course/scoped_models/product_scope_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../price_tag.dart';

class ProductsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return ScopedModelDescendant<ProductModel>(
          builder: (BuildContext context, Widget child, ProductModel model) {
              return ListView.builder(
                      itemCount: model.products != null ? model.products.length : 0,
                      itemBuilder: (BuildContext context, int pos) {
                          return Card(
                              child: Column(
                                  children: <Widget>[
                                      /*Our Product Image*/
                                      Image.asset(model.products[pos].productImage),
                                      Container(
                                              margin: EdgeInsets.only(top: 12.0),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                      /*Our ProductName*/
                                                      Text(
                                                          model.products[pos].productName,
                                                          style: TextStyle(
                                                                  fontSize: 26.0,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontFamily: 'SourceCode'),
                                                      ),
                                                      SizedBox(
                                                          width: 8.0,
                                                      ),
                                                      /*Our Product Price Tag widget*/
                                                      PriceTag(model.products[pos].productPrice
                                                              .toString()),
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
                                                  onPressed: () =>
                                                          Navigator.pushNamed<bool>(
                                                                  context, "/products",
                                                                  arguments: model.products[pos])
                                                                  .then((bool value) {
                                                              if (value == false) {
                                                                  return;
                                                              }
                                                              print(
                                                                      "object being passed from onBack pressed is $value");
                                                              model.deleteProduct(pos);
                                                          }),
                                                  color: Theme
                                                          .of(context)
                                                          .primaryColor,
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
          },
      );
  }
}
