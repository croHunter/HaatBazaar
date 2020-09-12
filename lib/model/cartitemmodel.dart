class CartItemModel {
  static const ID = "cartID"; //cartId
  static const NAME = "name";
  static const IMAGE = "imageURL";
  static const PRODUCT_ID = "id";
  static const PRICE = "price";
  static const QUANTITY = "quantity";

  String _id;
  String _name;
  String _image;
  String _productId;
  double _price;
  double _quantity;

  //creating a map
  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,
        QUANTITY: _quantity
      };

  //name constructor
  CartItemModel.fromMap(Map data) {
    _id = data[ID]; //cartId
    _name = data[NAME]; //product name
    _image = data[IMAGE]; //imageUrl
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
  }

  //  getters fot cart_List
  String get id => _id; //cartID
  String get name => _name;
  String get image => _image;
  String get productId => _productId;
  double get price => _price;
  double get quantity => _quantity;
}
