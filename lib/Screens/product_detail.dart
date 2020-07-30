import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'conform_order.dart';
import 'Home.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({
    this.gridIndex,
  });
  final int gridIndex;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with TickerProviderStateMixin {
  int weight = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            foregroundDecoration: BoxDecoration(
              color: Colors.black26,
            ),
            height: 400.0,
            width: double.infinity,
            child: Hero(
              tag: 'item${widget.gridIndex}',
              child: Image.asset(
                itemList.assetImage(widget.gridIndex),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        '${itemList.imageName(widget.gridIndex)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      color: itemList.containWish(widget.gridIndex)
                          ? Colors.redAccent
                          : Colors.white,
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        setState(() {
                          itemList.wishList(widget.gridIndex);
                        });

                        // assets.wishListItems.add(assets.images[index]);
                        //  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cauliflower is added to the Wish list'),));
                      },
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Weight'),
                              Text('$weight kg'),
                            ],
                          ),
                          Spacer(),
                          Column(
                            children: <Widget>[
                              Text('Total'),
                              Text(
                                  'Rs.${weight * itemList.price(widget.gridIndex)}'),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.white,
                              overlayColor: Color(0x29eb1555),
                              thumbColor: Color(0xffeb1555),
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 10.0,
                              ),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0)),
                          child: Slider(
                            value: weight.toDouble(),
                            onChanged: (double newValue) {
                              setState(() {
                                weight = newValue.round();
                              });
                            },
                            min: 0.0,
                            max: 10.0,
                            activeColor: Color(0xffeb1555),
                            inactiveColor: Color(0xff8d8e98),
                          ),
                        ),
                      ),
                      Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'This is the best product in the hystrory my name is sujan shrestha i live in nepal This is the best product in the hystrory my name is sujan shrestha i live in nepalThis is the best product in the hystrory my name is sujan shrestha i live in nepal This is the best product in the hystrory my name is sujan shrestha i live in nepalThis is the best product in the hystrory my name is sujan shrestha i live in nepal This is the best product in the hystrory my name is sujan shrestha i live in nepalThis is the best product in the hystrory my name is sujan shrestha i live in nepal This is the best product in the hystrory my name is sujan shrestha i live in nepalThis is the best product in the hystrory my name is sujan shrestha i live in nepal This is the best product in the hystrory my name is sujan shrestha i live in nepalThis is the best product in the hystrory my name i my name is sujan shrestha i live in nepal This is the best product in the hystrory my name is sujan shrestha i live in nepalThis is the best product in the hystrory my name is sujan shrestha i live in nepal This is the best product in ttrory my name is sujan shrestha i live in nepal',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Question about this Product'),
                              Spacer(),
                              InkWell(
                                onTap: () {},
                                child: Text('View all'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(child: Text('Q/A')),
                          SizedBox(
                            height: 10.0,
                          ),
                          FlatButton(
                            child: Text('Ask Question'),
                            onPressed: () {},
                          )
                        ],
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            height: 40.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 11.0),
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Text(
                      'Rs.${itemList.price(widget.gridIndex)}/kg',
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  InkWell(
                    onTap: () {
                      print('chat clicked');
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 11.0),
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Text(
                        'Chat',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.purple,
                      textColor: Colors.white,
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12.0),
                      ),
                      onPressed: () {
                        setState(() {
                          itemList.cartList2(widget.gridIndex);
                        });
                        // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Cauliflower is added to the Cart list'),));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      color: Colors.purple,
                      textColor: Colors.white,
                      child: Text(
                        'Buy',
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12.0),
                      ),
                      onPressed: () {
//                                Navigator.pushNamed(context, ConfirmOrder.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // int weight=5;
                              return ConfirmOrder(
                                total:
                                    weight * itemList.price(widget.gridIndex),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
