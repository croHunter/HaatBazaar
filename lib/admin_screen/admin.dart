import 'package:flutter/material.dart';

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
            Expanded(
              child: FlatButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPage = Page.dashboard;
                  });
                },
                icon: Icon(Icons.dashboard,
                    color: _selectedPage == Page.dashboard ? active : noActive),
                label: Text('Dashboard'),
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                onPressed: () {
                  setState(() {
                    _selectedPage = Page.manage;
                  });
                },
                icon: Icon(Icons.sort,
                    color: _selectedPage == Page.manage ? active : noActive),
                label: Text('Manage'),
              ),
            ),
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
          validator: (value) {
            if (value.isEmpty) {
              print('dfsf');
            }
          },
          decoration: InputDecoration(hintText: 'add category'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
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
              print('dfsf');
            }
          },
          decoration: InputDecoration(hintText: 'add brand'),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
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
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.filter_list),
            title: Text('Product list'),
            onTap: () {},
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
