import 'package:flutter_course/models/productPojo.dart';
import 'package:flutter_course/scoped_models/product_model.dart';
import 'package:flutter_course/scoped_models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with UserModel, ProductModel {
  @override
  void setProductAsFavourite(ProductPoJo productPoJo) {
    super.setProductAsFavourite(productPoJo);
    notifyListeners();
  }

  @override
  void toggleFavouriteMode() {
    super.toggleFavouriteMode();
    notifyListeners();
  }

  @override
  void addProduct(ProductPoJo poJo) {
    super.addProduct(poJo);
    notifyListeners();
  }
}
