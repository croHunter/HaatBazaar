import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/RefactorComponent/clippath.dart';
import 'package:haatbazaar/Screens/dashboard.dart';

import 'SignUp.dart';

//TODO: while login do verify password as well
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
  String smsSent, verificationId;

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

  bool showSpinner = false;
  Future<void> _verifyPhone(String phoneNo) async {
    setState(() {
      showSpinner = true;
    });
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+977 $phoneNo",
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
          setState(() {
            showSpinner = false;
          });

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
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    } else {
                      Navigator.of(context).pop();
                      signIn(smsSent);
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
      setState(() {
        showSpinner = false;
      });
      Navigator.pushNamed(context, Dashboard.id);
    }).catchError((e) {
      print('third error:$e');
    });
  }

  bool _obscureText = true;
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
            child: showSpinner
                ? Center(child: CircularProgressIndicator())
                : ListView(
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
                              phoneNo = value;
                            },
                            onChanged: (String value) {},
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              hintText: 'Phone',
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
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
                            obscureText: _obscureText,
                            onChanged: (String value) {},
                            cursorColor: Colors.deepOrange,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Material(
                                elevation: 0.0,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.red,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 13.0),
                              suffixIcon: InkWell(
                                onTap: () {
                                  if (_obscureText) {
                                    setState(() {
                                      _obscureText = false;
                                    });
                                  } else {
                                    setState(() {
                                      _obscureText = true;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.grey,
                                ),
                              ),
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
                                _verifyPhone(phoneNo);
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
