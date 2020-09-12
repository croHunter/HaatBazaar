import 'package:cloud_firestore/cloud_firestore.dart';

import 'cartitemmodel.dart';

class UserModel {
  static const ID = 'User Id';
  static const NAME = 'Full name';
  static const PHONE = 'Phone';
  // static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String _name;
  String _phone;
  String _id;
  // String _stripeId;
  int _priceSum = 0;
  // public variables
  List<CartItemModel> cart;
  int totalCartPrice;

  //name constructor
  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    _name = data[NAME];
    _id = data[ID];
    // _stripeId = snapshot.data[STRIPE_ID] ?? "";
    cart = _convertCartItems(data[CART] ??
        []); //mapping to the cart field if cart field is not null////its a dynamic list||  cart=[ [map1][map2][map3][map4][map5][map6]...]
    //  totalCartPrice = data[CART] == null ? 0 : getTotalPrice(cart: data[CART]);
  }
  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }

  //  getters
  String get name => _name;
  String get phone => _phone;
  String get id => _id;
  // String get stripeId => _stripeId;
  //List<CartItemModel> get getCart => cart;
  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"];
    }

    int total = _priceSum;
    return total;
  }
}
