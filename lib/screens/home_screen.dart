import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/product_model.dart';
import 'package:flutter_course/widget/loading.dart';
import 'package:flutter_course/widget/product/products_list.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void _getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        debugPrint("user email is nnn ${user.email}");
        loggedInUser = user;
      }
    } catch (e) {
      debugPrint("caught an exception with getting current user $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductViewModel>(context);
    List<Product> products;
    return Scaffold(
      drawer: Drawer(
        elevation: 8.0,
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('My Profile'),
              centerTitle: true,
            ),
            Container(
              height: 200.0,
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile_img.png'),
                      maxRadius: 60.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Kingsley Usoro',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
                title: Text('Manage Products'),
                leading: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                  size: 20.0,
                ),
                onTap: () => Navigator.pushReplacementNamed(context, "/manageProduct")),
            Divider(),
            ListTile(
              title: Text('Log out'),
              leading: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
              onTap: () => debugPrint("log out was clicked"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('EasyList'),
        elevation: 9.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              debugPrint("take users to their cart screen");
              Navigator.pushNamed(context, '/cartScreen');
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: productProvider.fetchProductsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinner();
          } else if (!snapshot.hasData) {
            return Center(child: Text("You have not created any products"));
          } else if (snapshot.hasData) {
            products = snapshot.data.documents
                .map((doc) => Product.fromJson(doc.data, doc.documentID))
                .where((product) => product.userEmail == loggedInUser.email)
                .toList();
            if (products == null || products.isEmpty) {
              return Center(
                  child: Text("You have not created any products",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)));
            } else {
              return ProductsList(products: products);
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
