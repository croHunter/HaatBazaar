import 'package:flutter/material.dart';

import 'DailyItem.dart';
import 'Home.dart';

class DailyIngredientItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: GridView.count(
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 15.0,
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        // controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List<Widget>.generate(
          itemList.itemLength(),
          (index) {
            return DailyItem(
              gridIndex: index,
            );
          },
        ),
      ),
    );
  }
}
