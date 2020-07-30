import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/DailyAnnaItem.dart';
import 'package:haatbazaar/Screens/DailyFruitItem.dart';
import 'package:haatbazaar/Screens/DailyIngredientItem.dart';
import 'package:haatbazaar/Screens/DailyVegetableItem.dart';
import 'Home.dart';
import 'Dairy.dart';
class DailyTabBar extends StatefulWidget {
  static String id = 'test';
  @override
  _DailyTabBarState createState() => _DailyTabBarState();
}

class _DailyTabBarState extends State<DailyTabBar> with SingleTickerProviderStateMixin {
  TabController tabController;
  int selectedDailyPage = 0;
  List<Widget> dailyPageList = [];
  @override
  void initState() {
    dailyPageList.add(DailyFruitItem());
    dailyPageList.add(DailyVegetableItem());
    dailyPageList.add(DailyIngredientItem());
    dailyPageList.add(DailyAnnaItem());
    dailyPageList.add(DailyDairyItem());
    tabController = TabController(length: 5, vsync: this,);
    super.initState();
  }



  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  double evenHeight(){
    double noOfRow=(itemList.itemLength()/2);
      double result=15*(noOfRow-1)+noOfRow*170;
      print(noOfRow);
      print('measured even height: $result');
    return result;
  }
  double oddHeight(){
    double noOfRow=((itemList.itemLength()/2)+0.5);// no. of row
    print(noOfRow);
    double result=noOfRow*146+(noOfRow-1)*15;//146 is total height of material widget
    print('measured odd height: $result');

    return result;
  }


  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white70,
          child: TabBar(
            controller: tabController,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.black,
            indicatorWeight: 4.0,
            unselectedLabelStyle:
                TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            labelStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
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
            onTap: (int index) {
              setState(() {
                selectedDailyPage = index;
              });
            },
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          height:itemList.itemLength()%2==0?evenHeight():oddHeight(),
          child: TabBarView(
            controller: tabController,
            children: dailyPageList,
          ),
        ),
      ],
    );
  }
}
