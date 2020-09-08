import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:haatbazaar/Model/slideItemList.dart';
import 'package:haatbazaar/Screens/DailyAnnaItem.dart';
import 'package:haatbazaar/Screens/DailyIngredientItem.dart';
import 'package:haatbazaar/Screens/DailyVegetableItem.dart';
import 'package:haatbazaar/Screens/cart_list.dart';
import 'package:haatbazaar/Screens/product_detail.dart';
import 'package:haatbazaar/constants.dart';
import 'package:haatbazaar/sidebar/main_drawer.dart';

import '../Model/itemList.dart';
import 'DailyFruitItem.dart';
import 'Dairy.dart';
import 'featuredProduct.dart';

ItemList itemList = ItemList();
SlideItemList slideItemList = SlideItemList();

class HomePage extends StatefulWidget {
  static String id = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool pageActive;
  TabController _tabController;

  List<Widget> dailyPageList = [];

  Widget appBarTitle = Text(
    'HaatBazaar',
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _controller = TextEditingController();
  bool isSearching;
  _HomePageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          isSearching = false;
        });
      } else {
        setState(() {
          isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 3),
      (Timer timer) {
        if (_currentPage < 5) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      },
    );
    _tabController = TabController(length: 5, vsync: this);

    dailyPageList.add(DailyFruitItem());
    dailyPageList.add(DailyVegetableItem());
    dailyPageList.add(DailyIngredientItem());
    dailyPageList.add(DailyAnnaItem());
    dailyPageList.add(DailyDairyItem());
    super.initState();
    getCurrentUser();
    isSearching = false;
  }

  void getCurrentUser() async {
    try {
      print('sj1');
      final user = _auth.currentUser;
      print(user);
      print('sj2');
      if (user != null) {
        loggedInUser = user;
        //  print(loggedInUser.phoneNumber);
        print(loggedInUser);
      }
    } catch (e) {
      print("second last error : $e");
    }
    print("here is error");
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  Widget categoryList(BuildContext context, index, products) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // int weight=5;
              return ProductDetail(
                gridIndex: index,
                name: products.data()['name'],
                imageUrl: products.data()['imageURL'],
                price: products.data()['price'],
                brand: products.data()['brand'],
                quantity: products.data()['quantity'],
                description: products.data()['description'],
                isOnSale: products.data()['isOnSale'],
                isFeatured: products.data()['isFeatured'],
                isDailyNeed: products.data()['isDailyNeed'],
                id: products.data()['id'],
              );
            },
          ),
        );
        setState(() {});
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black12,
              image: DecorationImage(
                image: NetworkImage(products.data()['imageURL']),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            width: 160.0,
            height: 200.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(children: <Widget>[
            products.data()['isOnSale']
                ? Text('Rs.${products.data()['price']}')
                : Text('Sold', style: TextStyle(color: Colors.red)),
            SizedBox(width: 10.0),
            Text(products.data()['name']),
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Scaffold(
          drawer: MainDrawer(
            auth: _auth,
            loggedInUser:
                loggedInUser != null ? loggedInUser.phoneNumber : 'Unknown',
          ),
          body: NestedScrollView(
//        controller: _scrollController,
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  title: appBarTitle,
                  centerTitle: true,
                  backgroundColor: Colors.redAccent,
                  floating: true,
                  actions: <Widget>[
                    GestureDetector(
                      child: icon,
                      onTap: () {
                        setState(() {
                          if (this.icon.icon == Icons.search) {
                            this.icon = Icon(
                              Icons.close,
                              color: Colors.white,
                            );
                            this.appBarTitle = TextField(
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.white),
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(color: Colors.white)),
                              onChanged: null,
                            );
                            _handleSearchStart();
                          } else {
                            _handleSearchEnd();
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        Navigator.pushNamed(context, CartList.id);
                      },
                      iconSize: 22,
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: kPaddingHomeTopics,
                    child: Text('DAILY NEEDS'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('product')
                          .where('isDailyNeed', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('something went wrong');
                        } else if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ));
                        } else {
                          return Container(
                            width: double.infinity,
                            height: 250.0,
                            margin: EdgeInsets.only(top: 5.0),
                            child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot products =
                                      snapshot.data.docs[index];
                                  return categoryList(context, index, products);
                                },
                                itemCount: snapshot.data.docs.length,
                                scrollDirection: Axis.horizontal),
                          );
                        }
                      }),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: kPaddingHomeTopics,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _firestore
                            .collection('product')
                            .where('isFeatured', isEqualTo: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('something went wrong');
                          } else if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent,
                            ));
                          } else {
                            final listOfFeaturedProducts = snapshot.data.docs;
                            List<String> listOfFeaturedUrl = [];
                            for (var featured in listOfFeaturedProducts) {
                              final String featuredUrl =
                                  featured.data()['imageURL'];
                              listOfFeaturedUrl.add(featuredUrl);
                              // DocumentSnapshot products = snapshot.data.docs[index];
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text('FEATURED PRODUCT'),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return FeaturedProduct(
                                                  products:
                                                      listOfFeaturedProducts);
                                            },
                                          ),
                                        );
                                      },
                                      child: Text('View all'),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 160.0,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: <Widget>[
                                        PageView.builder(
                                            onPageChanged: _onPageChanged,
                                            scrollDirection: Axis.horizontal,
                                            controller: _pageController,
                                            itemCount: listOfFeaturedUrl.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            listOfFeaturedUrl[
                                                                index]),
                                                        fit: BoxFit.cover)),
                                              );
                                            }),
                                      ]),
                                ),
                                Text('CATEGORIES'),
                                SizedBox(
                                  height: 10.0,
                                )
                              ],
                            );
                          }
                        }),
                  ),
                ),
                SliverPersistentHeader(
                    pinned: true,
                    delegate: _CustomTabBar(
                        child: PreferredSize(
                      preferredSize: Size.fromHeight(50.0),
                      child: Container(
                        color: Colors.yellow,
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: TabBar(
                          controller: _tabController,
                          labelColor: Colors.redAccent,
                          unselectedLabelColor: Colors.black,
                          indicatorWeight: 4.0,
                          unselectedLabelStyle: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal),
                          labelStyle: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                          indicatorColor: Colors.redAccent,
                          isScrollable: true,
                          tabs: <Widget>[
                            Tab(
                              text: 'Fruits',
                            ),
                            Tab(
                              text: 'Vegetables',
                            ),
                            Tab(
                              text: 'Cooking Essential',
                            ),
                            Tab(
                              text: 'Grains',
                            ),
                            Tab(
                              text: 'Dairy',
                            ),
                          ],
                        ),
                      ),
                    )))
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: dailyPageList,
            ),
          ),
        ),
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        'HaatBazaar',
        style: TextStyle(color: Colors.white),
      );
      isSearching = false;
      _controller.clear();
    });
  }
}

class _CustomTabBar implements SliverPersistentHeaderDelegate {
  _CustomTabBar({this.child});
  final PreferredSize child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return child;
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
