import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/Home.dart';
import 'package:haatbazaar/Screens/wish_list.dart';

import 'notification.dart';

class Account extends StatefulWidget {
  static String id = 'account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
          child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                    color: Colors.redAccent),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30.0,
                    ),
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
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pushNamed(context, WishList.id);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  color: Colors.redAccent,
                                ),
                                Text(
                                  'Favourite',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                            color: Colors.white,
                            elevation: 5.0,
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            color: Colors.white,
                            elevation: 5.0,
                            onPressed: () {
                              Navigator.pushNamed(context, Notifications.id);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.message, color: Colors.redAccent),
                                Text(
                                  'Message',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            color: Colors.white,
                            elevation: 5.0,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.cancel, color: Colors.redAccent),
                                Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: MaterialButton(
                            color: Colors.white,
                            elevation: 5.0,
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.help, color: Colors.redAccent),
                                Text(
                                  'Help',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  'User Information',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16.0,
                      color: Colors.black87),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 5.0,
                  child: Container(
//                      alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          leading: Icon(Icons.phone_android),
                          title: Text('Phone'),
                          subtitle: Text('9842396131'),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.grey,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          leading: Icon(Icons.email),
                          title: Text('Email'),
                          subtitle: Text('shresthasujan845@gmail.com'),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.grey,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          leading: Icon(Icons.my_location),
                          title: Text('Location'),
                          subtitle: Text('Palungtar, Gorkha'),
                        ),
                        Divider(
                          height: 5.0,
                          color: Colors.grey,
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 4.0),
                          leading: Icon(Icons.date_range),
                          title: Text('Joined Date'),
                          subtitle: Text('May 2, 2020'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Positioned(
              top: 30.0,
              right: 5.0,
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.settings,
                  color: Colors.grey.shade200,
                ),
              ))
        ],
      )),
    );
  }
}
