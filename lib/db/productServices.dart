import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haatbazaar/db/product.dart';
import 'package:uuid/uuid.dart';

class ProductServices {
  // Generate a v1 (time-based) id
  String _productId = Uuid().v1();
  String _tableName = 'product'; //reference
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //uploading the properties of individual products
  /*------------------------------------------------------*/
  uploadProduct(
      String productName,
      String brand,
      String category,
      double quantity,
      String imageURL,
      double price,
      String description,
      bool isDailyNeed,
      bool isFeatured,
      bool isOnSale) async {
    print('before creating table');
    try {
      await _firestore.collection(_tableName).doc(_productId).set({
        'name': productName,
        'id': _productId,
        'brand': brand,
        'category': category,
        'quantity': quantity,
        'imageURL': imageURL,
        'price': price,
        'description': description,
        'isDailyNeed': isDailyNeed,
        'isFeatured': isFeatured,
        'isOnSale': isOnSale,
      });
    } catch (e) {
      print('error in provideservie $e');
    }
    print('after creating table');
  }
  /*---------------------------------------------------------------*/

  Future<List<Product>> getFeaturedProductList() async => await _firestore
          .collection(_tableName)
          .where('isFeatured', isEqualTo: true)
          .get()
          .then((snap) {
        List<Product> featuredProducts = [];
        snap.docs.map(
            (snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
        return featuredProducts;
      });
  // Stream<QuerySnapshot> getFeaturedProduct() {
  //   return _firestore
  //       .collection(_tableName)
  //       .where('isFeatured', isEqualTo: true)
  //       .snapshots();
  // }
}

// List<Product> getFeaturedProductList(snapshot) {
//   List<Product> featuredProducts = [];
//   snapshot.docs
//       .map((snapshot) => featuredProducts.add(Product.fromSnapshot(snapshot)));
//   return featuredProducts;
// }
