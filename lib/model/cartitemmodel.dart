class CartItemModel {
  static const ID = "cartID"; //cartId
  static const NAME = "name";
  static const IMAGE = "imageURL";
  static const PRODUCT_ID = "id";
  static const PRICE = "price";
  // static const QUANTITIES = "quantities";
  static const QUANTITY = "quantity";

  String _id;
  String _name;
  String _image;
  String _productId;
  double _price;
  double _quantity;
  //String _quantities;

  //creating a map
  Map toMap() => {
        ID: _id,
        IMAGE: _image,
        NAME: _name,
        PRODUCT_ID: _productId,
        PRICE: _price,
        //   QUANTITIES: _quantities,
        QUANTITY: _quantity
      };

  //name constructor
  CartItemModel.fromMap(Map data) {
    _id = data[ID]; //cartId
    _name = data[NAME]; //product name
    _image = data[IMAGE]; //imageUrl
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    //_quantities = data[QUANTITIES];
    _quantity = data[QUANTITY];
  }

  //  getters fot cart_List
  String get id => _id; //cartID
  String get name => _name;
  String get image => _image;
  String get productId => _productId;
  double get price => _price;
//  String get quantities => _quantities;
  double get quantity => _quantity;
}
