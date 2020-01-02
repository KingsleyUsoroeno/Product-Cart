class ProductPojo {
  String _productName;
  String _productDesc;
  String _productImage;
  double _productPrice;

  ProductPojo(this._productName, this._productDesc, this._productImage,
      this._productPrice);

  double get productPrice => _productPrice;

  String get productImage => _productImage;

  String get productDesc => _productDesc;

  String get productName => _productName;

  @override
  String toString() {
    return 'ProductPojo{_productName: $_productName, _productDesc: $_productDesc, '
        '_productImage: $_productImage, _productPrice: $_productPrice}';
  }
}
