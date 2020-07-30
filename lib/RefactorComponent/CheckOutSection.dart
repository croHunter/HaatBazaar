import 'package:flutter/material.dart';

class CheckOutSection extends StatelessWidget {
  CheckOutSection({this.total, this.onPressed});
  final double total;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0), topRight: Radius.circular(50.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
        child: MaterialButton(
          onPressed: onPressed,
          elevation: 1.0,
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minWidth: double.infinity,
          child: Row(
            children: <Widget>[
              Text(
                'Countinue to checkout ',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
              Spacer(),
              Text('Rs. $total',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
