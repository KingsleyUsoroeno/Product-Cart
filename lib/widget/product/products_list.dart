import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/scoped_models/AppModel.dart';
import 'package:scoped_model/scoped_model.dart';

import '../price_tag.dart';

class ProductsList extends StatelessWidget {
  final List<ProductPoJo> products;

  ProductsList({this.products});

  @override
  Widget build(BuildContext context) {
    final appModel = ScopedModel.of<AppModel>(context, rebuildOnChange: true);
    return ListView.builder(
      // so there logic here will be to return products of only favourites or those that are not
        itemCount: products.length,
        itemBuilder: (BuildContext context, int pos) {
          ProductPoJo product = products[pos];
          return Card(
            child: Column(
              children: <Widget>[
                /*Our Product Image*/
                Image.network(product.productImage),
                Container(
                    margin: EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /*Our ProductName*/
                        Text(
                          product.productName,
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'SourceCode'),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        /*Our Product Price Tag widget*/
                        PriceTag(product.productPrice.toString()),
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
                Text(product.userEmail),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        appModel.setSelectedProductIndex(pos);
                        Navigator.pushNamed<bool>(context, "/products",
                            arguments: product)
                            .then((bool value) {
                          if (value == false) {
                            return;
                          }
                          print(
                              "object being passed from onBack pressed is $value");
                          appModel.deleteProduct();
                        });
                      },
                      color: Theme
                          .of(context)
                          .primaryColor,
                      icon: Icon(Icons.info),
                    ),
                    IconButton(
                      // OnPressed should make these Product our Favourite
                      icon: Icon(product.isFavourite || appModel.favourites
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: Colors.red,
                      onPressed: () {
                        appModel.setSelectedProductIndex(pos);
                        appModel.setProductAsFavourite(product);
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
