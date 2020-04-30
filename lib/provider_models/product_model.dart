import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:flutter_course/service/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductModel with ChangeNotifier {
  final _api = Api(path: "products");
  FirebaseUser _firebaseUser;
  final _auth = FirebaseAuth.instance;

  FirebaseUser get firebaseUser => _firebaseUser;

  ProductModel() {
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        debugPrint("user email is ${user.email}");
        _firebaseUser = user;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("caught an exception with getting current user $e");
    }
  }

  List<Product> products;

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<List<Product>> fetchProducts(String email, String documentID) async {
    setState(ViewState.Busy);
    final result = await _api.getDataCollection();
    products = result.documents
        .map((doc) => Product.fromJson(doc.data, documentID))
        .toList()
        .where((product) => product.userEmail == email)
        .toList();
    debugPrint("fetched products is $products");
    setState(ViewState.Idle);
    return products;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future updateProduct(Product data, String id) async {
    try {
      setState(ViewState.Busy);
      await _api.updateDocument(data.toJson(), id);
      setState(ViewState.Idle);
      return;
    } catch (e) {
      showToast("failed to create product, please try again");
      debugPrint("Caught an exception adding a product $e");
      setState(ViewState.Idle);
    }
  }

  Future addProduct(Product data) async {
    try {
      setState(ViewState.Busy);
      final result = await _api.addDocument(data.toJson());
      debugPrint("result is $result");
      setState(ViewState.Idle);
      showToast("Product added successfully");
      return;
    } catch (e) {
      showToast("failed to create product, please try again");
      debugPrint("Caught an exception adding a product $e");
      setState(ViewState.Idle);
    }
  }

  Future deleteProduct(String id) async {
    try {
      setState(ViewState.Busy);
      await _api.removeDocument(id);
      setState(ViewState.Idle);
      showToast("product deleted Successfully");
      return;
    } catch (e) {
      showToast("failed to delete product, please try again");
      debugPrint("Caught an exception delete a product $e");
      setState(ViewState.Idle);
    }
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
