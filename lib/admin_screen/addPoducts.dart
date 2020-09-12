import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/services/brand.dart';
import 'package:haatbazaar/services/category.dart';
import 'package:haatbazaar/services/productServices.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class AddProducts extends StatefulWidget {
  static String id = 'addProducts';

  @override
  _AddProductsState createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  bool isLoading = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productQuantityController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  String _name;
  String _price;
  String _quantity;
  String _description;

  CategoryServices _categoryServices = CategoryServices();
  BrandServices _brandServices = BrandServices();
  ProductServices _productServices = ProductServices();

  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];

  List<DropdownMenuItem> categoriesDropDown = <DropdownMenuItem>[];
  List<DropdownMenuItem> brandsDropDown = <DropdownMenuItem>[];

  String _currentCategory;
  String _currentBrand;

  bool isDailyNeed = false;
  bool isFeatured = false;
  bool isOnSale = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
    _getBrands();
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await _categoryServices
        .getCategories(); //[Instance of 'QueryDocumentSnapshot']
    print(data.length);
    print('data: $data');
    setState(() {
      categories = data; //[Instance of 'QueryDocumentSnapshot'] array form
      /*categories=[Instance of 'QueryDocumentSnapshot', Instance of 'QueryDocumentSnapshot', Instance of 'QueryDocumentSnapshot', Instance of 'QueryDocumentSnapshot']*/

      print(
          'test error: ${categories[0].data()}'); //{categoryName: Fruits} which is Map class
      print('test error2: ${categories[0].data()['categoryName']}'); //Fruits
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0].data()['categoryName']; //Fruits
    });
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
          i,
          DropdownMenuItem(
            child: Text(categories[i].data()['categoryName']),
            value: categories[i].data()['categoryName'],
          ),
        );
      });
    }
    return items;
  }

  void _getBrands() async {
    List<DocumentSnapshot> data = await _brandServices
        .getBrands(); //[Instance of 'QueryDocumentSnapshot']
    print(data.length);
    print('data: $data');
    setState(() {
      brands = data; //[Instance of 'QueryDocumentSnapshot']
      brandsDropDown = getBrandsDropDown();
      _currentBrand = brands[0].data()['BrandName']; //Fruits
    });
  }

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = List();
    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
          i,
          DropdownMenuItem(
            child: Text(brands[i].data()['BrandName']),
            value: brands[i].data()['BrandName'],
          ),
        );
      });
    }
    return items;
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
      print(_image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Products'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      height: 250.0,
                      width: 200.0,
                      margin: EdgeInsets.only(top: 5.0),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: _image == null
                            ? OutlineButton(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.8),
                                    width: 2.0),
                                onPressed: () {
                                  print('1');
                                  getImage();
                                  print('2');
                                },
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              )
                            : Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 5.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _productNameController,
                        decoration: InputDecoration(
                          hintText: 'Product Name',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'fill in the blanks';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (String value) {
                          _name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 5.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _productPriceController,
                        decoration: InputDecoration(
                          hintText: 'Price(Rs.)',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'fill in the blanks';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _price = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 5.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _productQuantityController,
                        decoration: InputDecoration(
                          hintText: 'Quantity(Max kg)',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'fill in the blanks';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _quantity = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 5.0),
                      child: TextFormField(
                        maxLines: 5,
                        keyboardType: TextInputType.text,
                        controller: _productDescriptionController,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'fill in the blanks';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          _description = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                      ),
                      child: CheckboxListTile(
                        activeColor: Colors.red,
                        title: Text(
                          'Daily need',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: isDailyNeed,
                        onChanged: (value) {
                          setState(() {
                            isDailyNeed = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                      ),
                      child: CheckboxListTile(
                        activeColor: Colors.red,
                        title: Text(
                          'Featured',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: isFeatured,
                        onChanged: (value) {
                          setState(() {
                            isFeatured = value;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.0,
                      ),
                      child: CheckboxListTile(
                        activeColor: Colors.red,
                        title: Text(
                          'Sale',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: isOnSale,
                        onChanged: (value) {
                          setState(() {
                            isOnSale = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            DropdownButton(
                                items: categoriesDropDown,
                                onChanged: (value) {
                                  setState(() {
                                    _currentCategory = value;
                                  });
                                },
                                value: _currentCategory),
                            Text(
                              'Category',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          children: [
                            DropdownButton(
                                items: brandsDropDown,
                                onChanged: (value) {
                                  setState(() {
                                    _currentBrand = value;
                                  });
                                },
                                value: _currentBrand),
                            Text(
                              'Brands',
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      color: Color(0xffff3a5a),
                      textColor: Colors.white,
                      child: Text(
                        'Add products',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                      onPressed: () {
                        validateAndUploadImage();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  validateAndUploadImage() async {
    if (_formKey.currentState.validate()) {
      if (_image != null) {
        setState(() {
          isLoading = true;
        });
        String imageURL;
        FirebaseStorage storage = FirebaseStorage.instance;

        final String picture =
            '${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
        try {
          StorageUploadTask taskToUploadImage =
              storage.ref().child(picture).putFile(_image);
          print(
              'taskToUploadImage: $taskToUploadImage'); //Instance of '_StorageFileUploadTask'
          StorageTaskSnapshot snapshotImage =
              await taskToUploadImage.onComplete.then((value) => value);
          print(
              'snapimage : $snapshotImage'); //Instance of 'StorageTaskSnapshot'

          taskToUploadImage.onComplete.then((value) async {
            imageURL = await snapshotImage.ref.getDownloadURL();
            print(
                'imageurl : $imageURL'); //https://firebasestorage.googleapis.com/v0/b/haatbazaar-e7dbb.appspot.com/o/1599196912210.jpg?alt=media&token=71d08837-93e3-42e8-b521-3c74571badac

            _productServices.uploadProduct(
                _name,
                _currentBrand,
                _currentCategory,
                double.parse(_quantity),
                imageURL,
                double.parse(_price),
                _description,
                isDailyNeed,
                isFeatured,
                isOnSale);
          }); //calling ProductServices to create the product table;

        } catch (e) {
          print("Error addproduct file at line 334 : $e");
        }
        // Toast.show('Product added', context);

        // setState(() {
        //   _image = null;
        //   isLoading = false;
        //   // isDailyNeed = false;
        //   // isFeatured = false;
        //   // isOnSale = false;
        // });
        //
        // _formKey.currentState.reset();
        // _productNameController.clear();
        // _productPriceController.clear();
        // _productQuantityController.clear();
      } else {
        setState(() {
          isLoading = false;
        });
        Toast.show('Please provide an image', context);
      }
    }
  }
}
