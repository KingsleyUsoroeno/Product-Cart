import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/models/user.dart';
import 'package:flutter_course/provider_models/auth_model.dart';
import 'package:flutter_course/provider_models/product_model.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:flutter_course/widget/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateProductScreenState();
  }
}

class CreateProductScreenState extends State<CreateProductScreen> {
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
      // ignore: missing_return
      validator: (String val) {
        if (val.trim().isEmpty) {
          return 'Product name is required';
        }
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
      // ignore: missing_return
      validator: (String input) {
        if (input.trim().isEmpty) {
          return 'Please provide a product description ';
        }
        if (input.trim().length < 10) {
          return 'product description should be more than 10 characters';
        }
      },
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      onSaved: (String val) {
        _formData['productDesription'] = val;
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      keyboardType: TextInputType.number,
      // ignore: missing_return
      validator: (String input) {
        if (input.trim().isEmpty) {
          return 'Please state a price';
        }
      },
      onSaved: (String val) {
        _formData['productPrice'] = double.parse(val);
      },
    );
  }

  void _saveProduct(ProductViewModel productProvider, AuthenticationViewModel authProvider) async {
    /** Form Validation*/
    if (_formKey.currentState.validate()) {
      // these simply means that if all validation logic is okay go ahead and save the inputs
      print('Saving input');
      _formKey.currentState.save();
      // only create a new product if we don't have a product to edit
      String productName = _formData["productName"];
      String productDes = _formData["productDesription"];
      double productPrice = _formData["productPrice"];
      String image = _formData["image"];
      User currentUser = await authProvider.getCurrentUser("user");
      String userId = currentUser.id;
      String email = currentUser.email;

      Product newProduct = Product(
          productId: new Uuid().v1().toString(),
          productName: productName,
          productDesc: productDes,
          productImage: image,
          productPrice: productPrice,
          userId: userId,
          userEmail: email);
      await productProvider.addProduct(newProduct);
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  Widget _buildSubmitButton(ProductViewModel provider, AuthenticationViewModel authProvider) {
    return RaisedButton(
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      child: Text('Save Product'),
      onPressed: () {
        _saveProduct(provider, authProvider);
      },
    );
  }

  // TODO create a custom textInput Widget that can be reUsed
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductViewModel>(context);
    final authProvider = Provider.of<AuthenticationViewModel>(context, listen: false);

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
                  child: _buildSubmitButton(productProvider, authProvider))
            ],
          ),
        ),
      ),
    );

    return productProvider.state == ViewState.Busy ? LoadingSpinner() : Scaffold(body: pageContent);
  }
}
