import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:haatbazaar/Model/slideItemList.dart';
import 'package:haatbazaar/Screens/DailyAnnaItem.dart';
import 'package:haatbazaar/Screens/DailyIngredientItem.dart';
import 'package:haatbazaar/Screens/DailyVegetableItem.dart';
import 'package:haatbazaar/constants.dart';
import 'package:haatbazaar/imageSlider/SlideItem.dart';
import 'package:haatbazaar/imageSlider/slideDots.dart';
import 'package:haatbazaar/sidebar/main_drawer.dart';

import '../Model/itemList.dart';
import 'DailyFruitItem.dart';
import 'Dairy.dart';
import 'cart_list.dart';

ItemList itemList = ItemList();
SlideItemList slideItemList = SlideItemList();

class HomePage extends StatefulWidget {
  static String id = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
        if (_currentPage < slideItemList.slideItemLength()) {
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
    isSearching = false;
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

  Widget categoryList(BuildContext context, index) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black12,
              image: DecorationImage(
                image: AssetImage(itemList.assetImage(index)),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(itemList.imageName(index)),
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
//      appBar: _showAppbar
//          ? buildAppBar(context)
//          : PreferredSize(
//              child: Container(),
//              preferredSize: Size(0.0, 0.0),
//            ),
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
                    child: Text('CATEGORIES'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    margin: EdgeInsets.only(top: 10.0),
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return categoryList(context, index);
                        },
                        itemCount: itemList.itemLength(),
                        scrollDirection: Axis.horizontal),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: kPaddingHomeTopics,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('FEATURED PRODUCT'),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Text('View all'),
                            )
                          ],
                        ),
                        Container(
                          height: 160.0,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: <Widget>[
                                PageView.builder(
                                    onPageChanged: _onPageChanged,
                                    scrollDirection: Axis.horizontal,
                                    controller: _pageController,
                                    itemCount: slideItemList.slideItemLength(),
                                    itemBuilder: (context, index) {
                                      return SlideItem(
                                        index: index,
                                      );
                                    }),
                                Container(
                                  height: 12,
                                  margin: EdgeInsets.only(left: 55.0),
                                  child: ListView.builder(
                                      itemBuilder: (ctx, i) {
                                        if (i == _currentPage) {
                                          pageActive = true;
                                        } else {
                                          pageActive = false;
                                        }
                                        return SlideDots(isActive: pageActive);
                                      },
                                      itemCount:
                                          slideItemList.slideItemLength(),
                                      scrollDirection: Axis.horizontal),
                                )
                              ]),
                        ),
                        Text('DAILY NEEDS'),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    ),
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
