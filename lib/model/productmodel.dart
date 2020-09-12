class ProductModel {
  static const IMAGE_URL = 'imageURL';
  static const NAME = 'name';
  static const BRAND = 'brand';
  static const CATEGORY = 'category';
  static const QUANTITY = 'quantity';
  static const DESCRIPTION = 'description';
  static const ID = 'id'; //productId
  static const PRICE = 'price';
  static const IS_DAILY_NEED = 'isDailyNeed';
  static const IS_FEATURED = 'isFeatured';
  static const IS_ON_SALE = 'isOnSale';

  String _productName;
  String _brand;
  String _category;
  double _quantity;
  String _description;
  String _imageURL;
  String _id;
  double _price;
  bool _isDailyNeed;
  bool _isFeatured;
  bool _isOnSale;
  // int _noOfProduct;

  //named constructor
  ProductModel.fromSnapshot(snapshot) {
    Map data = snapshot.data();
    _productName = data[NAME];
    _brand = data[BRAND];
    _category = data[CATEGORY];
    _quantity = data[QUANTITY];
    _description = data[DESCRIPTION];
    _imageURL = data[IMAGE_URL];
    _id = data[ID];
    _price = data[PRICE];
    _isDailyNeed = data[IS_DAILY_NEED];
    _isFeatured = data[IS_FEATURED];
    _isOnSale = data[IS_ON_SALE];
    // _noOfProduct = data.length;
  }

  String get productName => _productName;
  String get brand => _brand;
  String get category => _category;
  double get quantity => _quantity;
  String get description => _description;
  String get imageURL => _imageURL;
  String get id => _id;
  double get getPrice => _price;
  bool get isDailyNeed => _isDailyNeed;
  bool get isFeatured => _isFeatured;
  bool get isOnSale => _isOnSale;
  //int get noOfProduct => _noOfProduct;

}
