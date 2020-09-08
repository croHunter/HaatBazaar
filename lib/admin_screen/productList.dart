import 'package:flutter/material.dart';
import 'package:haatbazaar/db/product.dart';

import '../db/productServices.dart';

class ProductList extends StatefulWidget {
  static String id = 'productlist';
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  Future<List<Product>> list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = ProductServices().getFeaturedProductList();
    print(list); //Instance of 'Future<List<Product>>'
    print(list.then(
        (value) => value.asMap())); //Instance of 'Future<Map<int, Product>>'
    print(list.then((value) => value.map((e) => e.imageURL)));
    print(list.then((value) => value.asMap().forEach((key, value) {
          value.productName;
        })));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
              child: Text(
                  '${list.then((value) => value.asMap().forEach((key, value) {
                        value.noOfProduct;
                      }))}'));
        });
  }
}
