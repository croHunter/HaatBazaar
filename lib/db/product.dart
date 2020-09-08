import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  static const IMAGE_URL = 'imageURL';
  static const NAME = 'name';
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  static const QUANTITY = 'imageURL';
  static const ID = 'id';
  static const PRICE = 'price';
  static const IS_DAILY_NEED = 'isDailyNeed';
  static const IS_FEATURED = 'isFeatured';
  static const IS_ON_SALE = 'isOnSale';

  String _productName;
  String _brand;
  String _category;
  double _quantity;
  String _imageURL;
  String _id;
  double _price;
  bool _isDailyNeed;
  bool _isFeatured;
  bool _isOnSale;
  int _noOfProduct;

  Product.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _productName = data[NAME];
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _quantity = data[QUANTITY];
    _imageURL = data[IMAGE_URL];
    _id = data[ID];
    _price = data[PRICE];
    _isDailyNeed = data[IS_DAILY_NEED];
    _isFeatured = data[IS_FEATURED];
    _isOnSale = data[IS_ON_SALE];
    _noOfProduct = data.length;
  }

  String get productName => _productName;
  String get brand => _brand;
  String get category => _category;
  double get quantity => _quantity;
  String get imageURL => _imageURL;
  String get id => _id;
  double get getPrice => _price;
  bool get isDailyNeed => _isDailyNeed;
  bool get isFeatured => _isFeatured;
  bool get isOnSale => _isOnSale;
  int get noOfProduct => _noOfProduct;
}
