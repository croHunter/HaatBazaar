import 'dart:async';

import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/dashboard.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), () {
      Navigator.pushNamed(context, Dashboard.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.redAccent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                child: Center(
                  child: Icon(
                    Icons.fastfood,
                    color: Colors.green,
                    size: 60.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  'HaatBazaar',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      decoration: TextDecoration.none),
                ),
              ),


            ],
          ),
        ),
        Positioned(
          bottom: 30.0,
          left: 30.0,
          child: Column(
            children: <Widget>[

           // CircularProgressIndicator(),
            Text('Agriculture product shopping system',style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                decoration: TextDecoration.none),)
          ],),
        )
      ],
    );
  }
}
