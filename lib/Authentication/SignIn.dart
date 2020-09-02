import 'package:flutter/material.dart';
import 'package:haatbazaar/RefactorComponent/clippath.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  static String id = 'SignIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool _validated = false;
  String phoneNo, password;
  _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      _validated = true;
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future<void> signIn() async {}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: ListView(
              children: <Widget>[
                ClipPaths(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (String value) {
                        if (value.length != 10)
                          return 'Mobile Number must be of 10 digit';
                        else
                          return null;
                      },
                      onSaved: (String value) {
                        phoneNo = '+977 ' + value;
                      },
                      onChanged: (String value) {},
                      cursorColor: Colors.deepOrange,
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        prefixIcon: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: Icon(
                            Icons.phone_android,
                            color: Colors.red,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 13.0),
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
                    child: TextFormField(
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
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 13.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      color: Color(0xffff3a5a),
                      textColor: Colors.white,
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                      onPressed: () {
                        _validateInputs();
                        if (_validated) {
                          signIn();
                        }
                        _validated = false;
                      }),
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
                    onTap: () {},
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
                        'Register',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
