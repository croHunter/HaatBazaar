import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/account.dart';
import 'package:haatbazaar/Screens/cart_list.dart';
import 'package:haatbazaar/Screens/conform_order.dart';
import 'package:haatbazaar/Screens/dashboard.dart';
import 'package:haatbazaar/Authentication/SignIn.dart';
import 'package:haatbazaar/Screens/materialsplashscreen.dart';
import 'Authentication/SignUp.dart';
import 'Screens/dailyTabBar.dart';
import 'Screens/message.dart';
import 'Screens/wish_list.dart';
import 'admin_screen/admin.dart';

void main() => runApp(HaatBazaar());

class HaatBazaar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.redAccent,
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: Admin.id,
      //initialRoute: SplashScreen.id,
      routes: {
        Admin.id: (context) => Admin(),
        SplashScreen.id: (context) => SplashScreen(),
        Dashboard.id: (context) => Dashboard(),
        Account.id: (context) => Account(),
        HomePage.id: (context) => HomePage(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        ConfirmOrder.id: (context) => ConfirmOrder(),
        CartList.id: (context) => CartList(),
        WishList.id: (context) => WishList(),
        DailyTabBar.id: (context) => DailyTabBar(),
        Message.id: (context) => Message(),
      },
    );
  }
}
