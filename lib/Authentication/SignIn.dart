import 'package:flutter/material.dart';

import 'SignUp.dart';

class SignIn extends StatefulWidget {
  static String id = 'SignIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
    child: SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            children: <Widget>[
              Stack(children: <Widget>[
                ClipPath(
                  clipper: WaveClipper1(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x22ff3a5a), Color(0x22fe494d)])),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper2(),
                  child: Container(
                    child: Column(),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0x22ff3a5a), Color(0x22fe494d)])),
                  ),
                ),
                ClipPath(
                  clipper: WaveClipper3(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 30.0,),
                        Icon(Icons.fastfood, color: Colors.white, size: 60),
                        Text(
                          'HaatBazaar',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 30),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xffff3a5a), Color(0xfffe494d)])),
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: TextField(
                    onChanged: (String value) {},
                    cursorColor: Colors.deepOrange,
                    decoration: InputDecoration(
                      hintText: 'Phone/Email',
                      prefixIcon: Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: Icon(
                          Icons.perm_identity,
                          color: Colors.red,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25.0, vertical: 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (String value) {},
                    cursorColor: Colors.deepOrange,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Material(
                        elevation: 0.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: Icon(
                          Icons.lock,
                          color: Colors.red,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 25.0, vertical: 13.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: Color(0xffff3a5a),
                  ),
                  child: FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: InkWell(
                  child: Text(
                    'FORGOT PASSWORD ?',
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700),
                  ),
                  onTap: (){

                  },
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an Account?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.normal),
                  ),
                  InkWell(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline),
                    ),
                    onTap: (){
                          Navigator.pushNamed(context, SignUp.id);
                    },
                  ),

                ],
              )
            ],
          ),
        ),
    ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);
    var firstEndPoint = Offset(size.width * 0.7, size.height - 40);
    var firstControlPoint = Offset(size.width * 0.25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);
    var firstEndPoint = Offset(size.width * 0.6, size.height - 15 - 50);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 40);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);
    var firstEndPoint = Offset(size.width * 0.6, size.height - 29 - 50);
    var firstControlPoint = Offset(size.width * 0.25, size.height - 60 - 50);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    var secondEndPoint = Offset(size.width, size.height - 60);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
