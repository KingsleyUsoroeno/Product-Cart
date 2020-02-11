import 'package:flutter/material.dart';

class ProductPoJo {
    final String productName;
    final String productDesc;
    final String productImage;
    final double productPrice;
    final bool isFavourite;
    final String userId;
    final String userEmail;

  ProductPoJo(
      {@required this.productName,
      @required this.productDesc,
      @required this.productImage,
          @required this.productPrice,
          this.isFavourite = false,
          @required this.userId,
          @required this.userEmail});

  @override
  String toString() {
      return 'ProductPoJo{productName: $productName, productDesc: $productDesc, productImage: $productImage,'
              ' productPrice: $productPrice, isFavourite: $isFavourite, userId: $userId, userEmail: $userEmail}';
  }
}
