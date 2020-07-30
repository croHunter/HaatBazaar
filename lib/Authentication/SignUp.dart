import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool verifyPhone = false;
  String phone;
  String password;
  String confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: <Widget>[
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
                      SizedBox(height: 30),
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
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                  onChanged: (String value) {phone=value;},
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    hintText: 'Phone',
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
                  onChanged: (String value) {password=value;},
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                child: TextField(
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (String value) {confirmPassword=value;},
                  cursorColor: Colors.deepOrange,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
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

            //TODO:add check button in order to verify Phone number.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 65,),
              child: CheckboxListTile(
                  activeColor: Colors.red,
                  title: Text('Verify Phone',style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold,),),
                  value: verifyPhone,
                  onChanged: (value) {
                    setState(() {
                      verifyPhone = value;

                    });
                  },

              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'By clicking Sign Up you agree to following'),
                  TextSpan(
                      text: ' Terms and Conditions ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.indigo)),
                  TextSpan(text: 'with our reservations'),
                ]),
              ),
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
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                  onPressed: () {
                    if(verifyPhone==false||phone==null||password==null||confirmPassword==null){
                      //TODO: show dialogBox of warning to check verification of phone number,phone and passwords.
                    }
                  },
                ),
              ),
            ),
            Divider(
              color: Colors.black45,
              thickness: 1.0,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: <Widget>[
                  Text('or, connect with'),
                  SizedBox(
                    height: 10.0,
                  ),
                  OutlineButton.icon(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    borderSide: BorderSide(color: Color(0xffff3a5a)),
                    color: Color(0xffff3a5a),
                    highlightedBorderColor: Color(0xffff3a5a),
                    textColor: Color(0xffff3a5a),
                    icon: Icon(Icons.perm_identity,
                        size: 18.0), //FontAwesomeIcons.googlePlusG
                    label: Text('Google'),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ]),
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
