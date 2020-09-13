import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/wish_list.dart';
import 'package:haatbazaar/Screens/notification.dart';

import 'account.dart';

class Dashboard extends StatefulWidget {
  static String id = 'Dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  int _selectedPage = 0;
  List<Widget> pageList = [];
  Widget currentPage;
  // final PageStorageBucket bucket = PageStorageBucket();
  // final Key homeKey = PageStorageKey('homeKey');

  @override
  void initState() {
    pageList.add(HomePage(
        // key: homeKey,
        ));
    pageList.add(Notifications());
    pageList.add(WishList());
    pageList.add(Account());
    currentPage = pageList[0];
    super.initState();
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

  PageController _pageController = PageController();
  _onPageChanged(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
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
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                        color: _selectedPage == 0 ? Colors.red : Colors.grey),
                    title: Text(
                      'Home',
                      style: TextStyle(
                          color: _selectedPage == 0 ? Colors.red : Colors.grey),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble,
                        color: _selectedPage == 1 ? Colors.red : Colors.grey),
                    title: Text(
                      'Notification',
                      style: TextStyle(
                          color: _selectedPage == 1 ? Colors.red : Colors.grey),
                    )),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,
                        color: _selectedPage == 2 ? Colors.red : Colors.grey),
                    title: Text(
                      'Favourites',
                      style: TextStyle(
                          color: _selectedPage == 2 ? Colors.red : Colors.grey),
                    )),
                BottomNavigationBarItem(
                  icon: Icon(Icons.perm_identity,
                      color: _selectedPage == 3 ? Colors.red : Colors.grey),
                  title: Text(
                    'Account',
                    style: TextStyle(
                        color: _selectedPage == 3 ? Colors.red : Colors.grey),
                  ),
                ),
              ],
              // currentIndex: _selectedPage,
            )),
      ),
    );
  }
}
