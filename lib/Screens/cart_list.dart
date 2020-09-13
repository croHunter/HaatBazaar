import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/RefactorComponent/CWClearItemButton.dart';
import 'package:haatbazaar/RefactorComponent/CheckOutSection.dart';
import 'package:haatbazaar/RefactorComponent/RoundedMaterialButton.dart';
import 'package:haatbazaar/Screens/conform_order.dart';
import 'package:haatbazaar/Screens/product_detail.dart';

class CartList extends StatefulWidget {
  static String id = 'cartList';
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  final _key = GlobalKey<ScaffoldState>();

  //UserModel _userModel;
  //StreamController _event = StreamController<double>.broadcast();
  List<double> _counter = List();
  @override
  void initState() {
    try {
      print('cart length ${cartService.userModel.cart.length}');
    } catch (e) {
      print('cart error $e');
    }
    //_event.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      key: _key,
      body: SafeArea(
        child: cartService.userModel.cart.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartService.userModel.cart.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (_counter.length <
                            cartService.userModel.cart.length) {
                          _counter.add(1.0);
                        }
                        print(
                            'cart length ${cartService.userModel.cart.length}');

                        return Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              child: Material(
                                color: Colors.grey.shade100,
                                clipBehavior: Clip.antiAlias,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      height: 75.0,
                                      width: 90.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)),
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            cartService
                                                .userModel.cart[index].image,
                                          ),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Text(
                                                    cartService.userModel
                                                        .cart[index].name,
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    'Price: Rs.${cartService.userModel.cart[index].price} per kg',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Total: Rs. ${cartService.userModel.cart[index].price * cartService.userModel.cart[index].quantity}',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Card(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 5.0,
                                                          vertical: 0.0),
                                                      child: Text(
                                                        '${cartService.userModel.cart[index].quantity} kg',
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      RoundIconButton(
                                                        icon: Icons.remove,
                                                        onPressed: () {
                                                          // if (_counter[index] >=
                                                          //         0 &&
                                                          //     _counter[index] <
                                                          //         cartService
                                                          //             .userModel
                                                          //             .cart[
                                                          //                 index]
                                                          //             .quantities) {
                                                          //   _counter[index] =
                                                          //       _counter[
                                                          //               index] +
                                                          //           0.25;
                                                          // } else {
                                                          //   _counter[index] =
                                                          //       cartService
                                                          //           .userModel
                                                          //           .cart[index]
                                                          //           .quantities;
                                                          // }
                                                          // // _event.add(_counter[index]);
                                                          //
                                                          // setState(() {});
                                                        },
                                                      ),
                                                      RoundIconButton(
                                                        icon: Icons.add,
                                                        onPressed: () {
                                                          // if (_counter[index] >=
                                                          //         0 &&
                                                          //     _counter[index] <
                                                          //         cartService
                                                          //             .userModel
                                                          //             .cart[
                                                          //                 index]
                                                          //             .quantities) {
                                                          //   _counter[index] =
                                                          //       _counter[
                                                          //               index] +
                                                          //           0.25;
                                                          // } else {
                                                          //   _counter[index] =
                                                          //       cartService
                                                          //           .userModel
                                                          //           .cart[index]
                                                          //           .quantities;
                                                          // }
                                                          // // _event.add(_counter[index]);
                                                          //
                                                          // setState(() {});
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CWClearItem(
                              onPressed: () async {
                                bool success = await cartService.removeFromCart(
                                    cartItem:
                                        cartService.userModel.cart[index]);
                                if (success) {
                                  bool success_2 =
                                      await cartService.reloadUserModel();
                                  if (success_2) {
                                    _key.currentState.showSnackBar(SnackBar(
                                        content: Text("Item is deleted!")));
                                    print('reload success');
                                  } else {
                                    print('reload failed');
                                  }
                                  setState(() {});
                                  return;
                                } else {
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text("Not deleted")));
                                  return;
                                }
                                // setState(() {
                                //   // _counter.removeAt(index);
                                //   // itemList.removeCartItem(index);
                                // });
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  CheckOutSection(
                    total: cartService.userModel.totalCartPrice,
                    onPressed: () async {
//                      print(_event);
                      if (cartService.userModel.cart.isNotEmpty) {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // int weight=5;
                              return ConfirmOrder(
                                total: cartService.userModel.totalCartPrice,
                              );
                            },
                          ),
                        );
                        setState(() {});
                      } else {
                        _key.currentState.showSnackBar(
                            SnackBar(content: Text("Cart is empty")));
                      }
                    },
                  )
                ],
              )
            : Container(child: Center(child: Text('No product in your cart'))),
      ),
    );
  }
}
