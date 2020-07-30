import 'package:flutter/material.dart';
class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});
  final IconData icon;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawMaterialButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.white,
          size: 18.0,
        ),
        elevation: 0.0,
        constraints: BoxConstraints.tightFor(width: 25.0, height: 25.0),
        shape: CircleBorder(),
        fillColor: Color(0xff4c4f5e),
      ),
    );
  }
}