import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/Authentication/SignIn.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/account.dart';
import 'package:haatbazaar/Screens/cart_list.dart';
import 'package:haatbazaar/Screens/conform_order.dart';
import 'package:haatbazaar/Screens/dashboard.dart';
import 'package:haatbazaar/Screens/materialsplashscreen.dart';
import 'package:haatbazaar/admin_screen/addPoducts.dart';

import 'Authentication/SignUp.dart';
import 'Screens/notification.dart';
import 'Screens/wish_list.dart';
import 'admin_screen/admin.dart';
import 'admin_screen/productList.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(HaatBazaar());
}

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
      // initialRoute: Admin.id,
      initialRoute: SplashScreen.id,
      // initialRoute: Dashboard.id,
      // initialRoute: HomePage.id,

      routes: {
        Admin.id: (context) => Admin(),
        AddProducts.id: (context) => AddProducts(),
        SplashScreen.id: (context) => SplashScreen(),
        Dashboard.id: (context) => Dashboard(),
        Account.id: (context) => Account(),
        HomePage.id: (context) => HomePage(),
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        ConfirmOrder.id: (context) => ConfirmOrder(),
        CartList.id: (context) => CartList(),
        WishList.id: (context) => WishList(),
        //DailyTabBar.id: (context) => DailyTabBar(),
        Notifications.id: (context) => Notifications(),
        ProductList.id: (context) => ProductList(),
      },
    );
  }
}
