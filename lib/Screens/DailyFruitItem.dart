import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/product_detail.dart';
import 'package:haatbazaar/admin_screen/productList.dart';
import 'package:haatbazaar/model/productmodel.dart';

import 'Home.dart';

class DailyFruitItem extends StatefulWidget {
  @override
  _DailyFruitItemState createState() => _DailyFruitItemState();
}

class _DailyFruitItemState extends State<DailyFruitItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: productServices.getFruitSnaps(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ));
          } else if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData &&
              snapshot.data.docs.length > 0) {
            List<ProductModel> products =
                productServices.getProductModel(snapshot);
            print(products);
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
                  products.length,
                  (index) {
                    return InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // int weight=5;
                              return ProductDetail(
                                index: index,
                                products: products,
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
                                tag: 'item$index',
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                    color: Colors.black,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        products[index].imageURL,
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
                                      Text(products[index].productName,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          )),
                                      products[index].isOnSale
                                          ? Text(
                                              'Rs.${products[index].getPrice}',
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
          } else
            return Scaffold();
        });
    // GridViewCount();
  }
}
