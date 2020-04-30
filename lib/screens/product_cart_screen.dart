import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/cart_model.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:flutter_course/widget/loading.dart';
import 'package:provider/provider.dart';

class ProductCartScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductCartScreenState();
  }
}

class ProductCartScreenState extends State<ProductCartScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void _getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        debugPrint("user email is ${user.email}");
        loggedInUser = user;
      }
    } catch (e) {
      debugPrint("caught an exception with getting current user $e");
    }
  }

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartModel>(context);
    List<Product> products;
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: StreamBuilder(
        stream: cartProvider.fetchProductsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinner();
          }
          if (!snapshot.hasData) {
            return Center(child: Text("You have not created any products"));
          }

          if (snapshot.hasData) {
            products = snapshot.data.documents
                .map((doc) => Product.fromJson(doc.data, doc.documentID))
                .toList()
                .where((product) => product.userEmail == loggedInUser.email)
                .toList();
            return _buildProduct(products, cartProvider);
          }

          if (snapshot.hasError) {
            return Center(
                child: Column(
              children: <Widget>[
                Text(
                  "Could fetch your products",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text("Please check your internet connection and try again",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              ],
            ));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildProduct(List<Product> products, CartModel cartModel) {
    return cartModel.state == ViewState.Idle
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int position) {
              Product product = products[position];
              debugPrint("product is $product");
              return Column(
                children: <Widget>[
                  ListTile(
                      title: Text(product.productName),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(product.productImage),
                        radius: 30.0,
                      ),
                      subtitle: Text(product.productDesc),
                      contentPadding: EdgeInsets.all(8.0),
                      onTap: (() => Navigator.pushNamed(context, "/products", arguments: product))),
                  Divider()
                ],
              );
            },
          )
        : LoadingSpinner();
  }
}
