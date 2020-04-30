import 'package:flutter/material.dart';

class Product {
  String id;
  String productId;
  final String productName;
  final String productDesc;
  final String productImage;
  final dynamic productPrice;
  final bool isFavourite;
  final String userId;
  final String userEmail;

  Product(
      {this.id,
      @required this.productId,
      @required this.productName,
      @required this.productDesc,
      @required this.productImage,
      @required this.productPrice,
      this.isFavourite = false,
      @required this.userId,
      @required this.userEmail});

  Map<String, dynamic> toJson() => {
        'id': id,
        'productName': productName,
        'productDesc': productDesc,
        'productImage': productImage,
        'productPrice': productPrice,
        'isFavourite': isFavourite,
        'userId': userId,
        'userEmail': userEmail
      };

  Product.fromJson(Map snapshot, String id)
      : id = id ?? '',
        productId = snapshot['id'],
        productName = snapshot['productName'],
        productDesc = snapshot['productDesc'],
        productImage = snapshot['productImage'],
        productPrice = snapshot['productPrice'],
        isFavourite = snapshot['isFavourite'],
        userId = snapshot['userId'],
        userEmail = snapshot['userEmail'];

  @override
  String toString() {
    return 'ProductPoJo{productName: $productName, productDesc: $productDesc, productImage: $productImage,'
        ' productPrice: $productPrice, isFavourite: $isFavourite, userId: $userId, userEmail: $userEmail}';
  }
}
