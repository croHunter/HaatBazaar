import 'imageBank.dart';

class ItemList {
  //for item list
  List<ImageBank> _itemList = [
    ImageBank(
        image: 'images/0.jpg',
        imageName: 'Apple',
        price: 140.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/1.jpeg',
        imageName: 'All',
        price: 500.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/2.jpeg',
        imageName: 'Pinapple',
        price: 140.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/3.jpeg',
        imageName: 'Orange',
        price: 90.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/4.jpeg',
        imageName: 'Grapes',
        price: 180.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/5.jpeg',
        imageName: 'kharbuja',
        price: 50.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/6.jpeg',
        imageName: 'Anar',
        price: 120.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/7.jpeg',
        imageName: 'Grapes',
        price: 180.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/8.jpeg',
        imageName: 'Lemon',
        price: 85.0,
        maxWeight: 15.0),
    ImageBank(
        image: 'images/9.jpeg',
        imageName: 'Struberry',
        price: 70.0,
        maxWeight: 15.0),
  ];
  String assetImage(int index) {
    return _itemList[index].image;
  }

  String imageName(int index) {
    return _itemList[index].imageName;
  }

  double price(int index) {
    return _itemList[index].price;
  }

  double getMaxWeight(index) {
    return _itemList[index].maxWeight;
  }

  int itemLength() {
    return _itemList.length;
  }

  //for cart list
  List<ImageBank> _cartItemList = [];
  removeAllCartItem() {
    if (_cartItemList.isNotEmpty) {
      _cartItemList.removeRange(0, _cartItemList.length);
      return _cartItemList;
    }
  }

  String assetCartImage(int index) {
    return _cartItemList[index].image;
  }

  String cartImageName(int index) {
    return _cartItemList[index].imageName;
  }

  double cartPrice(int index) {
    return _cartItemList[index].price;
  }

  int cartItemLength() {
    return _cartItemList.length;
  }

  removeCartItem(int index) {
    return _cartItemList.remove(_cartItemList[index]);
  }

  containCart(int index) {
    return _cartItemList.contains(_itemList[index]);
  }

  void cartList(int index) {
    if (!_cartItemList.contains(_itemList[index])) {
      _cartItemList.add(_itemList[index]);
    } else {
      _cartItemList.remove(_itemList[index]);
    }
  }

  void cartList2(int index) {
    if (!_cartItemList.contains(_itemList[index])) {
      _cartItemList.add(_itemList[index]);
    } else {
      print('already exist!');
    }
  }

  double cartSum() {
    double total = 0;
    for (int i = 0; i < _cartItemList.length; i++) {
      total = total + _cartItemList[i].price;
    }
    return total;
  }

  isNotEmptyCart() {
    return _cartItemList.isNotEmpty;
  }

  //for wish list
  List<ImageBank> _wishItemList = [];
  removeAllWishItem() {
    if (_wishItemList.isNotEmpty) {
      _wishItemList.removeRange(0, _wishItemList.length);
      return _wishItemList;
    }
  }

  String assetWishImage(int index) {
    return _wishItemList[index].image;
  }

  String wishImageName(int index) {
    return _wishItemList[index].imageName;
  }

  double wishPrice(int index) {
    return _wishItemList[index].price;
  }

  int wishItemLength() {
    return _wishItemList.length;
  }

  removeWishItem(int index) {
    return _wishItemList.remove(_wishItemList[index]);
  }

  containWish(int index) {
    return _wishItemList.contains(_itemList[index]);
  }

  void wishList(int index) {
    if (!_wishItemList.contains(_itemList[index])) {
      _wishItemList.add(_itemList[index]);
    } else {
      _wishItemList.remove(_itemList[index]);
    }
  }

  double wishSum() {
    double total = 0;
    for (int i = 0; i < _wishItemList.length; i++) {
      total = total + _wishItemList[i].price;
    }
    return total;
  }

  isNotEmptyWish() {
    return _wishItemList.isNotEmpty;
  }
}
