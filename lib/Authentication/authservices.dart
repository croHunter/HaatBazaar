import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:haatbazaar/Authentication/SignIn.dart';
import 'package:haatbazaar/Screens/dashboard.dart';

import 'SignUp.dart';

class AuthService {
  static handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Dashboard();
        } else {
          return SignUp();
        }
      },
    );
  }

  static void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
