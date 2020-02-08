import 'package:flutter/material.dart';

class ProductPoJo {
  String productName;
  String productDesc;
  String productImage;
  double productPrice;

  ProductPoJo(
      {@required this.productName,
      @required this.productDesc,
      @required this.productImage,
      @required this.productPrice});

  @override
  String toString() {
    return 'ProductPojo{_productName: $productName, _productDesc: $productDesc, '
        '_productImage: $productImage, _productPrice: $productPrice}';
  }
}
