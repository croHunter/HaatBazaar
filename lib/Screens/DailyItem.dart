import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/product_detail.dart';
import 'Home.dart';

class DailyItem extends StatefulWidget {
  DailyItem({
    this.gridIndex,
  });
  final int gridIndex;
  @override
  _DailyItemState createState() => _DailyItemState();
}

class _DailyItemState extends State<DailyItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // int weight=5;
              return ProductDetail(
                gridIndex: widget.gridIndex,
              );
            },
          ),
        );
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
                  tag: 'item${widget.gridIndex}',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0)),
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage(
                          itemList.assetImage(widget.gridIndex),
                        ),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                )),
            Expanded(
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(itemList.imageName(widget.gridIndex),
                          style: TextStyle(
                            fontSize: 16.0,
                          )),
                      Text(
                        'Rs.${itemList.price(widget.gridIndex)}/kg',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            itemList.cartList(widget.gridIndex);
                          });
                        },
                        child: Icon(
                          Icons.add_shopping_cart,
                          size: 24.0,
                          color: itemList.containCart(widget.gridIndex)
                              ? Colors.blue
                              : Colors.black45,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            itemList.wishList(widget.gridIndex);
                          });
                        },
                        child: Icon(
                          Icons.favorite,
                          size: 24.0,
                          color: itemList.containWish(widget.gridIndex)
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
  }
}
