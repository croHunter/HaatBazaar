import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/RefactorComponent/CWClearItemButton.dart';
import 'package:haatbazaar/RefactorComponent/CWListItem.dart';
import 'package:haatbazaar/RefactorComponent/CheckOutSection.dart';
import 'package:haatbazaar/Screens/Home.dart';

import 'conform_order.dart';

class WishList extends StatefulWidget {
  static String id = 'wishList';

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
//  StreamController _event1 = StreamController<double>.broadcast();
  List<double> _counter1 = List();
  @override
  void initState() {
//    _event1.add(0);
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
                    'Your Wish list',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        itemList.removeAllWishItem();
                      });
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemList.wishItemLength(),
                itemBuilder: (BuildContext context, int index) {
                  if (_counter1.length < itemList.wishItemLength()) {
                    _counter1.add(1);
                  }
                  return Stack(
                    children: <Widget>[
                      CWListItem(
//                        stream: _event1.stream,
                        listIndex: index,
                        productAmount: _counter1[index],
                        total: 100.0,
                        onPressedMinus: () {
                          if (_counter1[index] <= 0) {
                            _counter1[index] = 0;
                          } else {
                            _counter1[index] = _counter1[index] - 0.25;
                          }
//                          _event.add(_counter[index]);
                          setState(() {});
                        },
                        onPressedPlus: () {
                          if (_counter1[index] >= 0 &&
                              _counter1[index] < itemList.getMaxWeight(index)) {
                            _counter1[index] = _counter1[index] + 0.25;
                          } else {
                            _counter1[index] = itemList.getMaxWeight(index);
                          }
//                          _event.add(_counter[index]);

                          setState(() {});
                        },
                        assetImage: itemList.assetWishImage(index),
                        itemName: itemList.wishImageName(index),
                        price: itemList.wishPrice(index),
                      ),
                      CWClearItem(
                        onPressed: () {
                          setState(() {
                            _counter1.removeAt(index);
                            itemList.removeWishItem(index);
                          });
//                          Scaffold.of(context).showSnackBar(SnackBar(
//                            content:
//                                Text('Cauliflower is removed from Cart list'),
//                            duration: Duration(milliseconds: 200),
//                          ));
                        },
                      )
                    ],
                  );
                },
              ),
            ),
            itemList.isNotEmptyWish()
                ? CheckOutSection(
                    total: itemList.wishSum(),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ConfirmOrder(
                              total: itemList.wishSum(),
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
