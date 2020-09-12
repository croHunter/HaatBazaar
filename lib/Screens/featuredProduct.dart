import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/product_detail.dart';
import 'package:haatbazaar/model/productmodel.dart';

import 'Home.dart';

class FeaturedProduct extends StatefulWidget {
  FeaturedProduct({this.products});
  final List<ProductModel> products;
  static String id = 'featuredProduct';
  @override
  _FeaturedProductState createState() => _FeaturedProductState();
}

class _FeaturedProductState extends State<FeaturedProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Featured Products'),
      ),
      body: Container(
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
            widget.products.length,
            (index) {
              return Material(
                color: Colors.white70,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // int weight=5;
                          return ProductDetail(
                            index: index,
                            products: widget.products,
                          );
                        },
                      ),
                    );
                    setState(() {});
                  },
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
                                  widget.products[index].imageURL,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(widget.products[index].productName,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    )),
                                widget.products[index].isOnSale
                                    ? Text(
                                        'Rs.${widget.products[index].getPrice}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ))
                                    : Text('Sold',
                                        style: TextStyle(color: Colors.red))
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
      ),
    );
  }
}
