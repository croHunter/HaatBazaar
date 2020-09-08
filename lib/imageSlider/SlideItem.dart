import 'package:flutter/material.dart';

import '../Screens/Home.dart';

class SlideItem extends StatelessWidget {
  SlideItem({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12,
          image: DecorationImage(
              image: AssetImage(slideItemList.assetSlideImage(index)),
              fit: BoxFit.cover)),
    );
  }
}
