import 'package:flutter/material.dart';
import 'package:haatbazaar/admin_screen/addPoducts.dart';
import 'package:haatbazaar/admin_screen/productList.dart';
import 'package:haatbazaar/services/brand.dart';
import 'package:haatbazaar/services/category.dart';
import 'package:toast/toast.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  static String id = 'admin';
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor noActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            InkWell(
                onTap: () {
                  setState(() {
                    _selectedPage = Page.dashboard;
                  });
                },
                child: Row(children: <Widget>[
                  Icon(Icons.dashboard,
                      color:
                          _selectedPage == Page.dashboard ? active : noActive),
                  Text('Dashboard', style: TextStyle(color: Colors.black))
                ])),
            InkWell(
                onTap: () {
                  setState(() {
                    _selectedPage = Page.manage;
                  });
                },
                child: Row(children: <Widget>[
                  Icon(Icons.developer_mode,
                      color: _selectedPage == Page.manage ? active : noActive),
                  Text('Manage', style: TextStyle(color: Colors.black))
                ])),
          ],
        ),
        backgroundColor: Colors.white,
//          elevation: 0.0,
      ),
      body: _loadScreen(),
    );
  }

  Widget adminDashboardButton(
      String text, IconData icon, Function onTap, String value) {
    return InkWell(
      onTap: onTap,
      child: Material(
        color: Colors.white70,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon),
                SizedBox(
                  width: 10.0,
                ),
                Text(text)
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60.0, color: active),
            )
          ],
        ),
      ),
    );
  }

  void _categoryAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (String value) {
            if (value.isEmpty) {
              return 'fill the text';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: 'add category'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (categoryController.text.isNotEmpty) {
              CategoryServices().createCategory(categoryController.text);
              Toast.show('${categoryController.text} is added', context);
              Navigator.pop(context);
            } else {
              Toast.show('fill in the blanks', context);
            }
          },
          child: Text('ADD'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _brandAlert() {
    var alert = AlertDialog(
      content: Form(
        key: _brandFormKey,
        child: TextFormField(
          controller: brandController,
          validator: (value) {
            if (value.isEmpty) {
              return 'fill the text';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(hintText: 'add brand'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            if (brandController.text.isNotEmpty) {
              BrandServices().createBrand(brandController.text);
              Toast.show('${brandController.text} is added', context);
              Navigator.pop(context);
            } else {
              Toast.show('fill in the blanks', context);
            }
          },
          child: Text('ADD'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
        ),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.attach_money,
                    size: 30.0,
                    color: Colors.green,
                  ),
                  label: Text(
                    '12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: Colors.green),
                  )),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: Colors.grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                    childAspectRatio: 1.1 //determines size of child
                    ),
                children: <Widget>[
                  adminDashboardButton('User', Icons.people_outline, () {
                    print("user");
                  }, '10'),
                  adminDashboardButton('Categories', Icons.people_outline, () {
                    print("categories");
                  }, '10'),
                  adminDashboardButton('Products', Icons.category, () {}, '10'),
                  adminDashboardButton('Sold', Icons.tag_faces, () {}, '10'),
                  adminDashboardButton(
                      'Orders', Icons.shopping_cart, () {}, '10'),
                  adminDashboardButton('Return', Icons.close, () {}, '10'),
                ],
              ),
            )
          ],
        );
        break;
      case Page.manage:
        return ListView(children: <Widget>[
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add product'),
            onTap: () {
              Navigator.pushNamed(context, AddProducts.id);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Product list'),
            onTap: () {
              Navigator.pushNamed(context, ProductList.id);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text('Add Categories'),
            onTap: () {
              _categoryAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Add brand'),
            onTap: () {
              _brandAlert();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Brand list'),
            onTap: () {},
          ),
        ]);
        break;
      default:
        return Container();
    }
  }
}
