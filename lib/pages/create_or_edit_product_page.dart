import 'package:flutter/material.dart';
import 'package:flutter_course/productPojo.dart';

class ProductCreateOrEditPage extends StatefulWidget {
  final Function addProduct;
  final Function updateProduct;
  final ProductPojo product;
  final int productIndex;

  ProductCreateOrEditPage(
      {this.addProduct, this.updateProduct, this.product, this.productIndex});

  @override
  State<StatefulWidget> createState() {
    return ProductCreateOrEditState();
  }
}

class ProductCreateOrEditState extends State<ProductCreateOrEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    "productName": "",
    "productDesription": "",
    "productPrice": 10,
    "image": "assets/images/food.jpg"
  };

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Text('These is a modal '),
          );
        });
  }

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Product Name'),
      initialValue: widget.product != null ? widget.product.productName : "",
      // ignore: missing_return
      validator: (String val) {
        if (val.trim().isEmpty) {
          return 'Product name is required';
        }
      },
      onSaved: (String val) {
        _formData['productName'] = val;
      },
    );
  }

  Widget _buildDescTextField() {
    return TextFormField(
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Product Description'),
      keyboardType: TextInputType.multiline,
      initialValue: widget.product != null ? widget.product.productDesc : "",
      // ignore: missing_return
      validator: (String input) {
        if (input.trim().isEmpty) {
          return 'Please Provide Product Description ';
        }
      },
      onSaved: (String val) {
        _formData['productDesription'] = val;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      initialValue:
          widget.product != null ? widget.product.productPrice.toString() : "",
      // ignore: missing_return
      validator: (String input) {
        if (input.trim().isEmpty) {
          return 'Please state price';
        }
      },
      onSaved: (String val) {
        _formData['productPrice'] = double.parse(val);
      },
    );
  }

  void _createProduct() {
    /** Form Validation*/
    if (_formKey.currentState.validate()) {
      // these simply means that if all validation logic is okay go ahead and save the inputs
      print('Saving input');
      _formKey.currentState.save();
      // only create a new product if we don't have a product to edit
      if (widget.product == null) {
        String productName = _formData["productName"];
        String productDes = _formData["productDesription"];
        double productPrice = _formData["productPrice"];
        String image = _formData["image"];

        ProductPojo product =
            ProductPojo(productName, productDes, image, productPrice);
        widget.addProduct(product);
      } else {
        String productName = _formData["productName"];
        String productDes = _formData["productDesription"];
        double productPrice = _formData["productPrice"];
        String image = _formData["image"];

        ProductPojo product =
            ProductPojo(productName, productDes, image, productPrice);
        print("product index is ${widget.productIndex}");
        widget.updateProduct(widget.productIndex, product);
      }
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  // TODO create a custom textInput Widget that can be reUsed
  @override
  Widget build(BuildContext context) {
    final Widget pageContent = GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            margin: EdgeInsets.all(12.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    _buildTitleTextField(),
                    _buildDescTextField(),
                    _buildPriceTextField(),
                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Text(widget.product != null
                            ? 'Edit Product'
                            : 'Save Product'),
                        onPressed: () => _createProduct(),
                      ),
                    )
                  ],
                ))));
    return widget.product == null
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text("Edit Product"),
            ),
            body: pageContent,
          );
  }
}
