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


  set productName(String value) {
    _productName = value;
  }

  @override
  String toString() {
    return 'ProductPojo{_productName: $_productName, _productDesc: $_productDesc, '
        '_productImage: $_productImage, _productPrice: $_productPrice}';
  }

  set productDesc(String value) {
    _productDesc = value;
  }

  set productImage(String value) {
    _productImage = value;
  }

  set productPrice(double value) {
    _productPrice = value;
  }
}
