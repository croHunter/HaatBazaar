import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/wish_list.dart';
import 'package:haatbazaar/sidebar/main_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'account.dart';
import 'message.dart';

class Dashboard extends StatefulWidget {
  static String id = 'Dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int _selectedPage = 0;
  List<Widget> pageList = [];
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  @override
  void initState() {
    pageList.add(HomePage());
    pageList.add(Message());
    pageList.add(WishList());
    pageList.add(Account());
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.phoneNumber);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.grey.shade100,
            elevation: 0,
            //  title: Text('Are you sure ?'),
            content: Text('Do you want to exit ?'),
            contentPadding: EdgeInsets.only(top: 10.0, left: 10.0),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'No',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              InkWell(
                onTap: () {
                  exit(0);
//                  Navigator.of(context).pop(true);
                },
                child: Text('Yes',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
              )
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: MainDrawer(
          loggedInUser: loggedInUser.phoneNumber,
        ),
        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
        bottomNavigationBar: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedFontSize: 11.0,
              selectedFontSize: 11.0,
              iconSize: 20.0,
              onTap: (int index) {
                setState(() {
                  _selectedPage = index;
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('Home')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble), title: Text('Messages')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), title: Text('Favourites')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_identity), title: Text('Account')),
              ],
              currentIndex: _selectedPage,
            )),
      ),
    );
  }
}
