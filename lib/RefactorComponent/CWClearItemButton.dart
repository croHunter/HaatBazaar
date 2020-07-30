import 'package:flutter/material.dart';
class CWClearItem extends StatelessWidget {
  CWClearItem({this.onPressed});
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top:0.0,
      right:0.0,
      child: Container(
        height: 24.0,
        width: 24.0,
        child:MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: EdgeInsets.all(0.0),
          color: Colors.redAccent,
          child: Icon(Icons.clear,color: Colors.white,),
          onPressed:onPressed,
        ),
      ),
    );
  }
}