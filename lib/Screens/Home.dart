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
import 'package:haatbazaar/admin_screen/productList.dart';
import 'package:haatbazaar/constants.dart';
import 'package:haatbazaar/db/product.dart';
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

  Widget categoryList(
      BuildContext context, int index, List<ProductModel> products) {
    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              // int weight=5;
              return ProductDetail(
                gridIndex: index,
                name: products[index].productName,
                imageUrl: products[index].imageURL,
                price: products[index].getPrice,
                brand: products[index].brand,
                quantity: products[index].quantity,
                description: products[index].description,
                isOnSale: products[index].isOnSale,
                isFeatured: products[index].isFeatured,
                isDailyNeed: products[index].isDailyNeed,
                id: products[index].id,
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
                image: NetworkImage(products[index].imageURL),
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
            products[index].isOnSale
                ? Text('Rs.${products[index].getPrice}')
                : Text('Sold', style: TextStyle(color: Colors.red)),
            SizedBox(width: 10.0),
            Text('${products[index].productName}'),
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
                      stream: productServices.getDailySnaps(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('something went wrong');
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ));
                        } else if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.hasData &&
                            snapshot.data.docs.length > 0) {
                          List<ProductModel> products =
                              productServices.getProductModel(snapshot);
                          print(products);
                          return Container(
                            width: double.infinity,
                            height: 250.0,
                            margin: EdgeInsets.only(top: 5.0),
                            child: ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return categoryList(context, index, products);
                                },
                                itemCount: products.length,
                                scrollDirection: Axis.horizontal),
                          );
                        } else
                          return Scaffold();
                      }),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: kPaddingHomeTopics,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: productServices.getFeaturedSnaps(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text('something went wrong');
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.lightBlueAccent,
                            ));
                          } else if (snapshot.connectionState ==
                                  ConnectionState.active &&
                              snapshot.hasData &&
                              snapshot.data.docs.length > 0) {
                            List<ProductModel> products =
                                productServices.getProductModel(snapshot);
                            print(products);
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
                                                  products: products);
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
                                            itemCount: products.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            products[index]
                                                                .imageURL),
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
                          } else
                            return Scaffold();
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
