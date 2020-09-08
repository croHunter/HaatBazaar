import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haatbazaar/db/product.dart';

import '../db/productServices.dart';

ProductServices productServices = ProductServices();

class ProductList extends StatefulWidget {
  static String id = 'productlist';
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: productServices.getAllProductSnaps(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.hasError) {
              return Text('something went wrong');
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ));
            } else if (snapshot.connectionState == ConnectionState.active &&
                snapshot.hasData &&
                snapshot.data.docs.length > 0) {
              List<ProductModel> products =
                  productServices.getProductModel(snapshot);
              print(products);
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black12,
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(products[index].imageURL),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                width: 160.0,
                                height: 250.0,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // InkWell(
                                      //   onTap:(){},
                                      //   child: Icon(
                                      //     Icons.update,
                                      //     color: Colors.deepOrange,
                                      //     size: 30.0,
                                      //   ),
                                      // ),
                                      Text('DETAILS',
                                          style: TextStyle(
                                              color: Colors.deepOrange)),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          productServices.deleteProducts(
                                              products[index].id,
                                              products[index].imageURL);
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Colors.deepOrange,
                                          size: 30.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text('Id: ${products[index].id}'),
                                  Text('Name: ${products[index].productName}'),
                                  Text('Brand: ${products[index].brand}'),
                                  Text('Category: ${products[index].category}'),
                                  Text('Quantity: ${products[index].quantity}'),
                                  Text('Price: ${products[index].getPrice}'),
                                  Text('Daily: ${products[index].isDailyNeed}'),
                                  Text(
                                      'Featured: ${products[index].isFeatured}'),
                                  Text('On Sale: ${products[index].isOnSale}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else
              return Scaffold();
          }),
    );
  }
}
