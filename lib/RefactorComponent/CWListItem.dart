import 'package:flutter/material.dart';

import 'RoundedMaterialButton.dart';

class CWListItem extends StatelessWidget {
  CWListItem(
      {this.listIndex,
      this.onPressedMinus,
      this.onPressedPlus,
      this.productAmount,
      this.onPressedDelete,
      this.assetImage,
      this.itemName,
      this.price,
      this.total});
  final int listIndex;
  final Function onPressedMinus;
  final Function onPressedDelete;
  final Function onPressedPlus;
  final double productAmount;
  final String assetImage;
  final String itemName;
  final double price;
//  final Stream<double> stream;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                  image: AssetImage(
                    assetImage,
                  ),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            itemName,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Price: Rs.$price per kg',
                            style: TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          Text(
                            'Total: Rs. $total',
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 0.0),
                              child: Text(
                                '$productAmount kg',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              RoundIconButton(
                                  icon: Icons.remove,
                                  onPressed: onPressedMinus),
                              RoundIconButton(
                                  icon: Icons.add, onPressed: onPressedPlus),
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
    );
  }
}
