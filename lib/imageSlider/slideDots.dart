import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  final bool isActive;
  SlideDots({this.isActive});
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 5.0),

      duration: Duration(milliseconds: 150),
//      margin: EdgeInsets.symmetric(),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
          color: isActive ? Colors.red : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }
}
