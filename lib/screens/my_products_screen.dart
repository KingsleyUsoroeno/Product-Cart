import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/product_model.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:flutter_course/screens/edit_product_screen.dart';
import 'package:flutter_course/widget/loading.dart';
import 'package:provider/provider.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AllProductsScreenState();
  }
}

class AllProductsScreenState extends State<AllProductsScreen> {
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
    final productProvider = Provider.of<ProductModel>(context);
    List<Product> products;
    return StreamBuilder(
      stream: productProvider.fetchProductsAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingSpinner();
        } else if (snapshot.hasData) {
          products = snapshot.data.documents
              .map((doc) => Product.fromJson(doc.data, doc.documentID))
              .toList()
              .where((product) => product.userEmail == loggedInUser.email)
              .toList();
          return _buildProduct(products, productProvider);
        } else {
          return Center(child: Text("You have not created any products"));
        }
      },
    );
  }

  Widget _buildProduct(List<Product> products, ProductModel productModel) {
    return productModel.state == ViewState.Idle
        ? ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int position) {
              Product product = products[position];
              return Dismissible(
                  key: Key(product.productName),
                  background: Container(
                    color: Colors.deepPurpleAccent,
                  ),
                  onDismissed: (DismissDirection dismissDirection) {
                    if (dismissDirection == DismissDirection.endToStart) {
                      print("Swiped from end to Start");
                      productModel.deleteProduct(product.id);
                    } else if (dismissDirection == DismissDirection.startToEnd) {
                      print("Swiped from start to end");
                      productModel.deleteProduct(product.id);
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(product.productName),
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(product.productImage),
                          radius: 30.0,
                        ),
                        subtitle: Text(product.productDesc),
                        contentPadding: EdgeInsets.all(8.0),
                        trailing: _buildIconButton(context, product, position),
                      ),
                      Divider()
                    ],
                  ));
            },
          )
        : LoadingSpinner();
  }

  Widget _buildIconButton(BuildContext context, Product product, int selectedIndex) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditProductScreen(productToEdit: product)));
      },
    );
  }
}
