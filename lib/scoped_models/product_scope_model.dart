import 'package:flutter_course/models/productPojo.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<ProductPoJo> _products = [];
  int _selectedProductIndex;
  bool _showFavourites = false;

  List<ProductPoJo> get getProducts {
    return List.from(_products);
  }

  List<ProductPoJo> get getProductsByFavourites {
    if (_showFavourites) {
      print("Show Favourites value is $_showFavourites");
      List<ProductPoJo> favouriteProduct = _products.where((ProductPoJo poJo) => poJo.isFavourite)
              .toList();
      print("favourite product is $favouriteProduct");
      return List.from(favouriteProduct);
    } else {
      return List.from(_products);
    }

  }

  void addProduct(ProductPoJo products) {
    _products.add(products);
    _selectedProductIndex = null;
    notifyListeners();
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
            isFavourite: isUpdateFav);
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
