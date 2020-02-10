import 'package:flutter/material.dart';

class ProductPoJo {
    final String productName;
    final String productDesc;
    final String productImage;
    final double productPrice;
    final bool isFavourite;

  ProductPoJo(
      {@required this.productName,
      @required this.productDesc,
      @required this.productImage,
          @required this.productPrice,
          this.isFavourite = false});

  @override
  String toString() {
    return 'ProductPojo{_productName: $productName, _productDesc: $productDesc, '
            '_productImage: $productImage, _productPrice: $productPrice, isFavourite: $isFavourite}';
  }
}
