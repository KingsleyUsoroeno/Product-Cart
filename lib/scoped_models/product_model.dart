import 'dart:convert';

import 'package:flutter_course/local/firebase_database.dart';
import 'package:flutter_course/models/productPojo.dart';
import 'package:http/http.dart' as httpClient;
import 'package:scoped_model/scoped_model.dart';

final String _databaseUrl = "https://flutter-products-7fe3f.firebaseio.com/products.json";

mixin ProductModel on Model {
  List<ProductPoJo> _allProduct = [];
  int _selectedProductIndex;
  bool _showFavourites = false;
  bool _isLoading = false;
  final _fireBaseDataBaseHelper = FirebaseDatabaseService();

  List<ProductPoJo> get getProducts {
    List<ProductPoJo> products = _showFavourites ? getProductsByFavourites : List.from(_allProduct);
    return products;
  }

  List<ProductPoJo> get allProducts {
    return _allProduct;
  }

  void setLoadingState(bool loadingStatus) {
    _isLoading = loadingStatus;
    print("is loading value is  $_isLoading");
    notifyListeners();
  }

  bool getLoadingState() {
    return _isLoading;
  }

  Future<List<ProductPoJo>> fetchProductsFromFirebase() async {
    try {
      final request = await httpClient.get(_databaseUrl);
      print(json.decode(request.body));
      List<ProductPoJo> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(request.body);

      fetchedProductList = productListData.keys.map((String productId) {
        final _product = productListData[productId];
        //_allProduct =  _product;
        return ProductPoJo(
            id: productId,
            productName: _product['name'],
            productDesc: _product['description'],
            productImage: _product['image'],
            isFavourite: _product['isFavourite'],
            productPrice: _product['price'],
            userEmail: _product['userEmail'],
            userId: _product['userId']);
      }).toList();
      return fetchedProductList;
    } catch (e) {
      print("Encoutered an error fetching products from fireBase $e");
      throw e;
    }
  }

  List<ProductPoJo> get getProductsByFavourites {
    if (_showFavourites) {
      print("Show Favourites value is $_showFavourites");
      List<ProductPoJo> favouriteProduct = _allProduct.where((ProductPoJo poJo) => poJo.isFavourite).toList();
      print("favourite product is $favouriteProduct");
      return List.from(favouriteProduct);
    } else {
      return List.from(_allProduct);
    }
  }

  Future addProduct(ProductPoJo productPoJo) async {
    _fireBaseDataBaseHelper.addProduct(productPoJo);
    notifyListeners();

//    try {
//      final Map<String, dynamic> productData = {
//        'name': productPoJo.productName,
//        'description': productPoJo.productDesc,
//        'image':
//            'https://www.wyldflour.com/wp-content/uploads/2019/04/Chocolate-Cake-with-Strawberry-Buttercream.jpg',
//        'price': productPoJo.productPrice,
//        'isFavourite': false,
//        'userEmail': productPoJo.userEmail,
//        'userId': productPoJo.userId
//      };
//
//      final response =
//          await httpClient.post(_databaseUrl, body: json.encode(productData));
//      final Map<String, dynamic> responseData = json.decode(response.body);
//      productPoJo.id = responseData['name'];
//      _allProduct.add(productPoJo);
//      _selectedProductIndex = null;
//      notifyListeners();
//    } catch (e) {
//      print("Caught an error while posting to FireBase $e");
//      throw e;
//    }
  }

  ProductPoJo getProduct() {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _allProduct[_selectedProductIndex];
  }

  void setProductAsFavourite(ProductPoJo productPoJo) {
    bool isCurrentlyFavourite = productPoJo.isFavourite;
    // if its true set its value to false// vise-versa
    // so these is inverted so if ti was true it is going to be false, if it was false its going to be true
    final bool isUpdateFav = !isCurrentlyFavourite;
    ProductPoJo updatedProduct = ProductPoJo(
        id: productPoJo.id,
        productName: productPoJo.productName,
        productDesc: productPoJo.productDesc,
        productImage: productPoJo.productImage,
        productPrice: productPoJo.productPrice,
        isFavourite: isUpdateFav,
        userEmail: productPoJo.userEmail,
        userId: productPoJo.userId);
    if (_selectedProductIndex != null) {
      _allProduct[_selectedProductIndex] = updatedProduct;
      _selectedProductIndex = null;
      notifyListeners();
    }
  }

  Future<httpClient.Response> updateProduct(ProductPoJo product) async {
    try {
      if (_selectedProductIndex != null) {
        print("Product is ${_allProduct[_selectedProductIndex]}");
        _allProduct[_selectedProductIndex] = product;
        _selectedProductIndex = null;
        print("Updated product is ${_allProduct.toString()}");
        notifyListeners();
      }

      final Map<String, dynamic> updatedProductData = {
        'name': product.productName,
        'description': product.productDesc,
        'price': product.productPrice,
        'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRpIGo_FgYwa_mATbL5TNgS3Fyv7bUfMEUtYTF9iSMjN0bJZW77',
        'userEmail': product.userEmail,
        'userId': product.userId
      };

      print("product id is ${product.id}");
      return await httpClient.put("https://flutter-products-7fe3f.firebaseio.com/products/${product.id}.json", body: json.encode(updatedProductData));
    } catch (e) {
      print("Caught an exception fetching Products from firebase $e");
    }
  }

  void deleteProduct() {
    if (_selectedProductIndex != null) {
      _allProduct.removeAt(_selectedProductIndex);
      _selectedProductIndex = null;
      notifyListeners();
    }
  }

  void setSelectedProductIndex(int index) {
    _selectedProductIndex = index;
    print("Selected Product index is $_selectedProductIndex");
  }

  int getSelectedProductIndex() {
    return _selectedProductIndex;
  }

  void toggleFavouriteMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }

  bool get favourites {
    return _showFavourites;
  }
}
