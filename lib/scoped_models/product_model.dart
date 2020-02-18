import 'dart:convert';

import 'package:flutter_course/models/productPojo.dart';
import 'package:http/http.dart' as httpClient;
import 'package:scoped_model/scoped_model.dart';

final String _databaseUrl = "https://flutter-products-7fe3f.firebaseio.com/";

mixin ProductModel on Model {
  List<ProductPoJo> _products = [];
  int _selectedProductIndex;
  bool _showFavourites = false;
  bool isLoading = false;

  List<ProductPoJo> get getProducts {
    List<ProductPoJo> products =
    _showFavourites ? getProductsByFavourites : List.from(_products);
    return products;
  }

  List<ProductPoJo> get allProducts {
    return _products;
  }

  void fetchProductsFromFirebase() {
    isLoading = true;
    httpClient
            .get(_databaseUrl + "products.json")
            .then((httpClient.Response response) {
      print(json.decode(response.body));

      final List<ProductPoJo> fetchedProductList = [];
      final Map<String, dynamic> productListData = json.decode(response.body);
      productListData.forEach((String productId, dynamic productData) {
        ProductPoJo productPoJo = ProductPoJo(
                id: productId,
                productName: productData['name'],
                productDesc: productData['description'],
                productImage: productData['image'],
                isFavourite: productData['isFavourite'],
                productPrice: productData['price'],
                userEmail: productData['userEmail'],
                userId: productData['userId']);
        fetchedProductList.add(productPoJo);
        isLoading = false;
      });

      print("fetched product list is $fetchedProductList");
      _products = fetchedProductList;
      print("isLoading Value is $isLoading");
      notifyListeners();
    }).catchError((e) {
      print("Encoutered an error fetching products from fireBase $e");
    });
  }

  List<ProductPoJo> get getProductsByFavourites {
    if (_showFavourites) {
      print("Show Favourites value is $_showFavourites");
      List<ProductPoJo> favouriteProduct =
      _products.where((ProductPoJo poJo) => poJo.isFavourite).toList();
      print("favourite product is $favouriteProduct");
      return List.from(favouriteProduct);
    } else {
      return List.from(_products);
    }
  }

  void addProduct(ProductPoJo productPoJo) {
    isLoading = true;
    final Map<String, dynamic> productData = {
      'name': productPoJo.productName,
      'description': productPoJo.productDesc,
      'image':
      'https://www.wyldflour.com/wp-content/uploads/2019/04/Chocolate-Cake-with-Strawberry-Buttercream.jpg',
      'price': productPoJo.productPrice,
      'isFavourite': false,
      'userEmail': productPoJo.userEmail,
      'userId': productPoJo.userId
    };

    httpClient
            .post(_databaseUrl + "products.json", body: json.encode(productData))
            .then((httpClient.Response response) {
      isLoading = false;
      final Map<String, dynamic> responseData = json.decode(response.body);
      productPoJo.id = responseData['name'];
      print("response data from Firebase is $responseData");
    }).catchError(() {
      print("Caught an error while posting to FireBase");
    });

    _products.add(productPoJo);
    print("Added product is $productPoJo");
    _selectedProductIndex = null;
  }

  ProductPoJo getProduct() {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  void setProductAsFavourite(ProductPoJo productPoJo) {
    bool isCurrentlyFavourite = productPoJo.isFavourite;
    // if its true set its value to false// vise-versa
    // so these is inverted so if ti was true it is going to be false, if it was false its going to be true
    final bool isUpdateFav = !isCurrentlyFavourite;
    ProductPoJo updatedProduct = ProductPoJo(
            productName: productPoJo.productName,
            productDesc: productPoJo.productDesc,
            productImage: productPoJo.productImage,
            productPrice: productPoJo.productPrice,
            isFavourite: isUpdateFav,
            userEmail: productPoJo.userEmail,
            userId: productPoJo.userId);
    if (_selectedProductIndex != null) {
      _products[_selectedProductIndex] = updatedProduct;
      _selectedProductIndex = null;
      notifyListeners();
    }
  }

  void updateProduct(ProductPoJo product) {
    if (_selectedProductIndex != null) {
      print("Product is ${_products[_selectedProductIndex]}");
      if (_products != null) {
        _products[_selectedProductIndex] = product;
        _selectedProductIndex = null;
        print("Updated product is ${_products.toString()}");
        notifyListeners();
      }
    }
  }

  void deleteProduct() {
    if (_selectedProductIndex != null) {
      _products.removeAt(_selectedProductIndex);
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
