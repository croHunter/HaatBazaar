import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haatbazaar/RefactorComponent/clippath.dart';
import 'dart:async';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:haatbazaar/Screens/dashboard.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _auth = FirebaseAuth.instance;
//  bool verifyPhone = false;
  String fullName, password, confirmPassword, phoneNo, smsSent, verificationId;
  bool showSpinner = false;
//  bool codeSent = false;
  bool validated = false;
  Future<void> _verifyPhone(String phoneNo) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        //1
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await _auth.signInWithCredential(credential);
        },
        //2
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          print('extra error :${e.message}');
          // Handle other errors
        },
        //3
        codeSent: (String verId, int forceResendingToken) async {
          // Update the UI - wait for the user to enter the SMS code
          //String smsCode = 'xxxx';
          verificationId = verId;
          print('ID $verificationId');

          smsCodeDialog(context).then((value) {
            print("Code Sent");
            print('value: $value');
          });
        },
        //4
        timeout: const Duration(seconds: 5),
        //default 30s
        codeAutoRetrievalTimeout: (String verId) {
          // Auto-resolution timed out...
          verificationId = verId;
        },
      );
    } catch (e) {
      print('Extra error2: $e');
    }
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text('Enter sms code'),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              this.smsSent = value;
            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                      setState(() {
                        showSpinner = false;
                      });
                    } else {
                      Navigator.of(context).pop();
                      signIn(smsSent);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } catch (e) {
                    print('forth error: $e');
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsSent);

    // Sign the user in (or link) with the credential
    await _auth.signInWithCredential(phoneAuthCredential).then((user) {
      Navigator.pushNamed(context, Dashboard.id);
    }).catchError((e) {
      print('third error:$e');
    });
  }

  _validateInputs() {
    if (_formKey.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState.save();
      validated = true;
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: ListView(children: <Widget>[
                ClipPaths(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      validator: (String value) {
                        if (value.length < 3)
                          return 'Name must be more than 2 charater';
                        else
                          return null;
                      },
                      onSaved: (String val) {
                        fullName = val;
                      },
                      cursorColor: Colors.deepOrange,
                      decoration: InputDecoration(
                        hintText: 'Full name',
                        prefixIcon: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          child: Icon(
                            Icons.person_outline,
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
//                      onChanged: (String value) {
//                        phoneNo = '+977 ' + value;
//                      },
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
                      obscureText: true,
                      onChanged: (String value) {
                        password = value;
                      },
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String value) {
                        confirmPassword = value;
                      },
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
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 13.0),
                      ),
                    ),
                  ),
                ),

                //TODO:add check button in order to verify Phone number.

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: 'By clicking Sign Up you agree to following'),
                      TextSpan(
                          text: ' Terms and Conditions ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo)),
                      TextSpan(text: 'with our reservations'),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                  ),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    color: Color(0xffff3a5a),
                    textColor: Colors.white,
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    onPressed: () {
                      _validateInputs();
                      if (validated) {
                        _verifyPhone(phoneNo);
                      }
                      validated = false;
                    },
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
        ),
      ),
    );
  }
}
