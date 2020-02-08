import 'package:flutter_course/models/productPojo.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductModel extends Model {
  List<ProductPoJo> _products = [];

  List<ProductPoJo> get products {
    return List.from(_products);
  }

  void addProduct(ProductPoJo products) {
    _products.add(products);
  }

  void updateProduct(int index, ProductPoJo product) {
    print("Product is ${_products[index]}");
    if (_products != null) {
      _products[index] = product;
    }
    print("Updated product is ${_products.toString()}");
  }

  void deleteProduct(int position) {
    _products.removeAt(position);
  }
}
