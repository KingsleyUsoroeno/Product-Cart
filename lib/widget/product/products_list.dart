import 'package:flutter/material.dart';
import 'package:flutter_course/scoped_models/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../price_tag.dart';

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          // so there logic here will be to return products of only favourites or those that are not
                itemCount: model.favourites
                        ? model.getProductsByFavourites.length
                        : model.getProducts.length,
                itemBuilder: (BuildContext context, int pos) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        /*Our Product Image*/
                        Image.asset(model.favourites
                                ? model.getProductsByFavourites[pos].productImage
                                : model.getProducts[pos].productImage),
                        Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    /*Our ProductName*/
                                    Text(
                                      model.favourites
                                              ? model
                                              .getProductsByFavourites[pos].productName
                                              : model.getProducts[pos].productName,
                                      style: TextStyle(
                                              fontSize: 26.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'SourceCode'),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    /*Our Product Price Tag widget*/
                                    PriceTag(model.favourites
                                            ? model
                                            .getProductsByFavourites[pos].productPrice
                                            .toString()
                                            : model.getProducts[pos].productPrice
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
//                    Text(model.favourites
//                        ? model.getProductsByFavourites[pos].userEmail
//                        : model.getProducts[pos].userEmail),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                model.setSelectedProductIndex(pos);
                                Navigator.pushNamed<bool>(context, "/products",
                                        arguments: model.getProducts[pos])
                                        .then((bool value) {
                                  if (value == false) {
                                    return;
                                  }
                                  print(
                                          "object being passed from onBack pressed is $value");
                                  model.deleteProduct();
                                });
                              },
                              color: Theme
                                      .of(context)
                                      .primaryColor,
                              icon: Icon(Icons.info),
                            ),
                            IconButton(
                              // OnPressed should make these Product our Favourite
                              icon: Icon(model.getProducts[pos].isFavourite ||
                                      model.favourites
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                              color: Colors.red,
                              onPressed: () {
                                model.setSelectedProductIndex(pos);
                                model.setProductAsFavourite(model.getProducts[pos]);
                              },
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
