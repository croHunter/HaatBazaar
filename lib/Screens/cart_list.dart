import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/RefactorComponent/CWClearItemButton.dart';
import 'package:haatbazaar/RefactorComponent/CWListItem.dart';
import 'package:haatbazaar/RefactorComponent/CheckOutSection.dart';
import 'package:haatbazaar/Screens/conform_order.dart';
import 'Home.dart';

class CartList extends StatefulWidget {
  static String id = 'cartList';
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
//  StreamController _event = StreamController<double>.broadcast();
  List<double> _counter = List();
  @override
  void initState() {
//    _event.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                bottom: 4.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Your Cart list',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        itemList.removeAllCartItem();
                      });
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemList.cartItemLength(),
                itemBuilder: (BuildContext context, int index) {
                  if (_counter.length < itemList.cartItemLength()) {
                    _counter.add(1.0);
                  }

                  return Stack(
                    children: <Widget>[
                      CWListItem(
                        listIndex: index,
                        productAmount: _counter[index],
                        onPressedMinus: () {
                          if (_counter[index] <= 0) {
                            _counter[index] = 0;
                          } else {
                            _counter[index] = _counter[index] - 0.25;
                          }
//                          _event.add(_counter[index]);
                          setState(() {});
                        },
                        onPressedPlus: () {
                          if (_counter[index] >= 0 &&
                              _counter[index] < itemList.getMaxWeight(index)) {
                            _counter[index] = _counter[index] + 0.25;
                          } else {
                            _counter[index] = itemList.getMaxWeight(index);
                          }
//                          _event.add(_counter[index]);

                          setState(() {});
                        },
//                        stream: _event.stream,
                        total: 100.0,
                        assetImage: itemList.assetCartImage(index),
                        itemName: itemList.cartImageName(index),
                        price: itemList.cartPrice(index),
                      ),
                      CWClearItem(
                        onPressed: () {
                          setState(() {
                            _counter.removeAt(index);
                            itemList.removeCartItem(index);
                          });
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            content:
//                                Text('Cauliflower is removed from Cart list'),
//                            duration: Duration(milliseconds: 200),
//                          ));
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            itemList.isNotEmptyCart()
                ? CheckOutSection(
                    total: itemList.cartSum(),
                    onPressed: () {
//                      print(_event);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // int weight=5;
                            return ConfirmOrder(
                              total: itemList.cartSum(),
                            );
                          },
                        ),
                      );
                    },
                  )
                : Container(
                    height: 0.0,
                    width: 0.0,
                  ),
          ],
        ),
      ),
    );
  }
}
