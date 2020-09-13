import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/product_detail.dart';
import 'package:haatbazaar/model/ordermodel.dart';

class Notifications extends StatefulWidget {
  static String id = 'notification';
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Notification'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: cartService.orders.length,
          itemBuilder: (_, index) {
            OrderModel _order = cartService.orders[index];
            return ListTile(
              leading: Text("${_order.total}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              title: Text(_order.description),
              subtitle: Text(
                  DateTime.fromMillisecondsSinceEpoch(_order.createdAt)
                      .toString()),
              trailing: Text(
                '${_order.status}',
                style: TextStyle(color: Colors.green),
              ),
            );
          }),
    );
  }
}
