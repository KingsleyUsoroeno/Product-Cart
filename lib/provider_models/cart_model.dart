import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/provider_models/view_state.dart';
import 'package:flutter_course/service/api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartViewModel with ChangeNotifier {
  final _api = Api(path: "cart");

  List<Product> products;

  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future addProductToCart(Product data) async {
    try {
      setState(ViewState.Busy);
      final result = await _api.addDocument(data.toJson());
      debugPrint("result is $result");
      setState(ViewState.Idle);
      showToast("Product Added to Cart");
      return;
    } catch (e) {
      showToast("failed to add product to cart, please try again");
      debugPrint("Caught an exception adding a product to cart $e");
      setState(ViewState.Idle);
    }
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future deleteProductFromCart(String id) async {
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

  bool doesProductAlreadyExistInCart(List<Product> products, Product product) {
    return products.contains(product);
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM);
  }
}
