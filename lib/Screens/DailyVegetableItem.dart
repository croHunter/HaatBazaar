import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/product_detail.dart';

import 'Home.dart';

class DailyVegetableItem extends StatefulWidget {
  @override
  _DailyVegetableItemState createState() => _DailyVegetableItemState();
}

class _DailyVegetableItemState extends State<DailyVegetableItem> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('product')
            .where('category', isEqualTo: 'Vegetable')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          } else if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          } else {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: GridView.count(
                physics: ClampingScrollPhysics(),
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                crossAxisCount: 2,
                childAspectRatio: 1.0,
//        controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List<Widget>.generate(
                  snapshot.data.docs.length,
                  (index) {
                    DocumentSnapshot products = snapshot.data.docs[index];
                    return InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // int weight=5;
                              return ProductDetail(
                                gridIndex: index,
                                name: products.data()['name'],
                                imageUrl: products.data()['imageURL'],
                                price: products.data()['price'],
                                brand: products.data()['brand'],
                                quantity: products.data()['quantity'],
                                description: products.data()['description'],
                                isOnSale: products.data()['isOnSale'],
                                isFeatured: products.data()['isFeatured'],
                                isDailyNeed: products.data()['isDailyNeed'],
                                id: products.data()['id'],
                              );
                            },
                          ),
                        );
                        setState(() {});
                      },
                      child: Material(
                        color: Colors.white70,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Hero(
                                tag: 'item${index}',
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        products.data()['imageURL'],
                                      ),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(products.data()['name'],
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          )),
                                      products.data()['isOnSale']
                                          ? Text(
                                              'Rs.${products.data()['price']}',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                              ))
                                          : Text('Sold',
                                              style:
                                                  TextStyle(color: Colors.red))
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          itemList.cartList(index);
                                        },
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          size: 24.0,
                                          color: itemList.containCart(index)
                                              ? Colors.blue
                                              : Colors.black45,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          itemList.wishList(index);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          size: 24.0,
                                          color: itemList.containWish(index)
                                              ? Colors.redAccent
                                              : Colors.black45,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // return DailyItem(

                    // );
                  },
                ),
              ),
            );
          }
        });
    ;
  }
}
