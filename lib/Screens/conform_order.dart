import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/Screens/product_detail.dart';
import 'package:haatbazaar/model/cartitemmodel.dart';
import 'package:haatbazaar/services/orderservices.dart';
import 'package:uuid/uuid.dart';

OrderServices orderServices = OrderServices();

class ConfirmOrder extends StatefulWidget {
  static String id = 'ConfirmOrder';
  ConfirmOrder({
    this.total,
  });
  final double total;
  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  //TODO:get the name of products and respective price and quantity
  final _key = GlobalKey<ScaffoldState>();
  double deliveryFee = 10.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text('Conform Order'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Subtotal',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Rs. ${widget.total}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Delivery fee',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Rs. $deliveryFee',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Rs. ${widget.total + deliveryFee}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'DELIVERY ADDRESS',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              RadioListTile(
                selected: true,
                value: 'Pulchok, Chitwan',
                groupValue: 'Pulchok, Chitwan',
                title: Text('Pulchok, Chitwan'),
                onChanged: (value) {},
              ),
              RadioListTile(
                selected: true,
                value: 'New Address',
                groupValue: 'Pulchok, Chitwan',
                title: Text('Choose new delivery address'),
                onChanged: (value) {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'CONTACT NUMBER',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              RadioListTile(
                selected: true,
                value: '9842396131',
                groupValue: '9842396131',
                title: Text('9842396131'),
                onChanged: (value) {},
              ),
              RadioListTile(
                selected: true,
                value: 'New Phone',
                groupValue: '9842396131',
                title: Text('Choose new contact number'),
                onChanged: (value) {},
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'PAYMENT OPTION',
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
              RadioListTile(
                selected: true,
                value: true,
                groupValue: true,
                title: Text('Cash on Delivery'),
                onChanged: (value) {},
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 18.0),
                child: MaterialButton(
                  onPressed: () async {
                    var uuid = Uuid();
                    String id = uuid.v4();
                    orderServices.createOrder(
                        userId: cartService.getUserId(),
                        id: id,
                        description: "Some random description",
                        status: "complete",
                        totalPrice: widget.total,
                        cart: cartService.userModel.cart);
                    for (CartItemModel cartItem in cartService.userModel.cart) {
                      bool value =
                          await cartService.removeFromCart(cartItem: cartItem);
                      if (value) {
                        await cartService.reloadUserModel();
                        bool success = await cartService.getOrders();
                        if (success) {
                          print('calling order is success');
                        } else {
                          print('calling order is failed');
                        }
                        print("Item added to cart");
                        _key.currentState.showSnackBar(
                            SnackBar(content: Text("Removed from Cart!")));
                      } else {
                        print("ITEM WAS NOT REMOVED");
                      }
                    }
                    _key.currentState.showSnackBar(
                        SnackBar(content: Text("Order created!")));
                    Navigator.pop(context);
                  },
                  elevation: 1.0,
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minWidth: double.infinity,
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
