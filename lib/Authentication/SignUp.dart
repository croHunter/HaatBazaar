import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/RefactorComponent/clippath.dart';
import 'package:haatbazaar/Screens/dashboard.dart';
import 'package:haatbazaar/db/userInfo.dart';

class SignUp extends StatefulWidget {
  static String id = 'SignUp';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  bool _verified = false;
  final _auth = FirebaseAuth.instance;

  String fullName,
      password,
      confirmPassword,
      phoneNo,
      smsSent,
      verificationId,
      location;
  bool showSpinner = false;
  bool validated = false;
  UserInfoService _userInfoService = UserInfoService();
  Future<void> _verifyPhone(String phoneNo) async {
    setState(() {
      showSpinner = true;
    });
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+977 $phoneNo',
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

      setState(() {
        _verified = true;
      });
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

  //var paswd=  /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{7,15}$/;
/*
r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])          // should contain at least one digit
 (?=.*?[!@#\$&*~]).{8,}  // should contain at least one Special character
$
*/
  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'at least one upper,one lower, one digit and one special character required';
      if (value.length < 8) return 'password must be of at least 8 character';
      if (value.length > 15)
        return 'password must be of at most 15 character';
      else
        return null;
    }
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
                : ListView(children: <Widget>[
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
                              return 'Name must be of at least 3 character';
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
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
                          keyboardType: TextInputType.name,
                          validator: (String value) {
                            if (value.length < 5)
                              return 'Location must be more than 5 charater';
                            else
                              return null;
                          },
                          onSaved: (String val) {
                            location = val;
                          },
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                            hintText: 'Location',
                            prefixIcon: Material(
                              elevation: 0.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
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
                            phoneNo = value;
                          },
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
                          validator: validatePassword,
                          onChanged: (String value) {
                            password = value;
                          },
                          onSaved: (String value) {
                            password = value;
                          },
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
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          validator: (String value) {
                            if (confirmPassword != password) //equivalent
                              return 'wrong password';
                            else
                              return null;
                          },
                          onChanged: (String value) {
                            confirmPassword = value;
                          },
                          onSaved: (String value) {
                            confirmPassword = value;
                          },
                          cursorColor: Colors.deepOrange,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
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
                          ),
                        ),
                      ),
                    ),

                    //TODO:add check button in order to verify Phone number.

                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text:
                                  'By clicking Sign Up you agree to following'),
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
                            if (_verified) {
                              //creating the user data
                              _userInfoService.createUser(
                                  fullName, phoneNo, password, location);
                            }
                            _verified = false;
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
    );
  }
}
