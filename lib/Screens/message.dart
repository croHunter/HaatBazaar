import 'package:flutter/material.dart';
import 'ChatScreen.dart';
import 'NotificationScreen.dart';

class Message extends StatefulWidget {
  static String id = 'message';
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> with SingleTickerProviderStateMixin {
  TabController tabController;
  List<Widget> messageList = [];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    messageList.add(ChatScreen());
    messageList.add(NotificationScreen());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: TabBar(
                  controller: tabController,
                  labelColor: Colors.redAccent,
                  unselectedLabelColor: Colors.black,
                  indicatorWeight: 4.0,
                  unselectedLabelStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                  labelStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  indicatorColor: Colors.redAccent,
                  isScrollable: false,
                  tabs: <Widget>[
                    Tab(
                      text: 'Chat',
                    ),
                    Tab(
                      text: 'Notification',
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: messageList,
          ),
        ),
      ),
    );
  }
}
