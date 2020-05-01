import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/cart_model.dart';
import 'package:flutter_course/provider_models/product_model.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:flutter_course/widget/loading.dart';
import 'package:provider/provider.dart';

import '../price_tag.dart';

// Todo re-work  delete product provider
class ProductsList extends StatelessWidget {
  final List<Product> products;

  ProductsList({this.products});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartViewModel>(context);
    final productProvider = Provider.of<ProductViewModel>(context);

    return cartProvider.state == ViewState.Idle
        ? ListView.builder(
            // so there logic here will be to return products of only favourites or those that are not
            itemCount: products.length,
            itemBuilder: (BuildContext context, int pos) {
              Product product = products[pos];
              debugPrint("product id is ${product.id}");
              return Card(
                child: Column(
                  children: <Widget>[
                    /*Our Product Image*/
                    Image.asset(product.productImage),
                    Container(
                        margin: EdgeInsets.only(top: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /*Our ProductName*/
                            Text(product.productName,
                                style: TextStyle(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SourceCode')),
                            SizedBox(width: 8.0),
                            /*Our Product Price Tag widget*/
                            PriceTag("\$${product.productPrice}"),
                          ],
                        )),
                    /** Location textView*/
                    Container(
                      padding: EdgeInsets.all(4.0),
                      child: Text('These is going to be the product location'),
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
                            //productProvider.setSelectedProductIndex(pos);
                            Navigator.pushNamed<bool>(context, "/products", arguments: product)
                                .then((bool value) {
                              if (value == false) {
                                return;
                              }
                              print("object being passed from onBack pressed is $value");
                              productProvider.deleteProduct(product.id);
                            });
                          },
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.info),
                        ),
                        IconButton(
                          // OnPressed should make these Product our Favourite
                          icon: Icon(Icons.shopping_cart),
                          color: Colors.red,
                          onPressed: () {
                            debugPrint("Add products to cart called");
                            // TODO before adding product to cart we need to check if product isn't already in cart
                            cartProvider.addProductToCart(product);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            })
        : LoadingSpinner();
  }
}
