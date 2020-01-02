import 'package:flutter/material.dart';
import 'package:flutter_course/productPojo.dart';

class ProductCreatePage extends StatefulWidget {
  final Function _addProduct;

  ProductCreatePage(this._addProduct);

  @override
  State<StatefulWidget> createState() {
    return ProductCreateState();
  }
}

class ProductCreateState extends State<ProductCreatePage> {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Text('These is a modal '),
          );
        });
  }

  String _productName;
  String _productDesc;
  double _price;

  // TODO create a custom textInput Widget that can be reUsed
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(12.0),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
              onChanged: (String val) {
                setState(() {
                  _productName = val;
                });
              },
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(labelText: 'Product Description'),
              keyboardType: TextInputType.multiline,
              onChanged: (String val) {
                setState(() {
                  _productDesc = val;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (String val) {
                setState(() {
                  _price = double.parse(val);
                });
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text('Save Product'),
                onPressed: () {
                  if (_productName == null && _productDesc == null) {
                    return;
                  }

                  ProductPojo product = ProductPojo(_productName, _productDesc,
                          "assets/images/food.jpg", _price);
                  print('Product to be added is ${product.toString()}');
                  widget._addProduct(product);
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
            )
          ],
        ));
  }
}
