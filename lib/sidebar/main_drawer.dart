import 'package:flutter/material.dart';
import 'package:haatbazaar/Authentication/SignIn.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/account.dart';
import 'package:haatbazaar/Screens/wish_list.dart';

class MainDrawer extends StatelessWidget {
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
                      'Sujan Shrestha',
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
                    FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignIn.id);
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
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
