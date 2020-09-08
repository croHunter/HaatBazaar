import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/Authentication/SignIn.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/account.dart';
import 'package:haatbazaar/Screens/dashboard.dart';
import 'package:haatbazaar/Screens/wish_list.dart';
import 'package:haatbazaar/admin_screen/admin.dart';

class MainDrawer extends StatefulWidget {
  MainDrawer({this.loggedInUser, this.auth});
  final FirebaseAuth auth;
  final String loggedInUser;

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
                color: Theme.of(context).primaryColor,
              ),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Account.id);
                },
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        itemList.assetImage(1),
                      ),
                      radius: 50.0,
                    ),
                    Text(
                      widget.loggedInUser,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text(
                      '(Customer)'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                          color: Colors.black45),
                    ),
                    widget.loggedInUser != 'Unknown'
                        ? FlatButton(
                            onPressed: () {
                              setState(() {
                                widget.auth.signOut();
                              });
                              Navigator.pushNamed(context, Dashboard.id);
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ))
                        : FlatButton(
                            onPressed: () {
                              Navigator.pushNamed(context, SignIn.id);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ListFlatButton(
              title: 'Favourites',
              icon: Icons.favorite,
              onPressed: () {
                Navigator.pushNamed(context, WishList.id);
              },
            ),
            ListFlatButton(
              title: 'Log out',
              icon: Icons.exit_to_app,
              onPressed: () {},
            ),
            ListFlatButton(
              title: 'Feedback',
              icon: Icons.feedback,
              onPressed: () {},
            ),
            ListFlatButton(
              title: 'Help',
              icon: Icons.help,
              onPressed: () {},
            ),
            ListFlatButton(
              title: 'Contact',
              icon: Icons.contacts,
              onPressed: () {},
            ),
            ListFlatButton(
              title: 'Settings',
              icon: Icons.settings,
              onPressed: () {},
            ),
            ListFlatButton(
              title: 'Admin',
              icon: Icons.person_pin,
              onPressed: () {
                Navigator.pushNamed(context, Admin.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListFlatButton extends StatelessWidget {
  ListFlatButton({this.title, this.icon, this.onPressed});
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
        leading: Icon(
          icon,
          size: 24,
        ),
      ),
    );
  }
}
