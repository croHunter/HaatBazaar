import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:haatbazaar/model/productmodel.dart';
import 'package:path/path.dart' as Path;
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
  Future<void> deleteProducts(String id, String imageUrl) async {
    await _firestore.collection(_tableName).doc(id).delete(); //delete the table
    //delete file storage
    var fileUrl = Uri.decodeFull(Path.basename(imageUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');

    final StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
  }

  Stream<QuerySnapshot> getAllProductSnaps() {
    return _firestore.collection(_tableName).snapshots();
  }

  Stream<QuerySnapshot> getDailySnaps() {
    return _firestore
        .collection('product')
        .where('isDailyNeed', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getFeaturedSnaps() {
    return _firestore
        .collection('product')
        .where('isFeatured', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getFruitSnaps() {
    return _firestore
        .collection('product')
        .where('category', isEqualTo: 'Fruit')
        .snapshots();
  }

  Stream<QuerySnapshot> getVegetableSnaps() {
    return _firestore
        .collection('product')
        .where('category', isEqualTo: 'Vegetable')
        .snapshots();
  }

  List<ProductModel> getProductModel(snapshot) {
    List<ProductModel> products = [];
    try {
      for (DocumentSnapshot product in snapshot.data.docs) {
        products.add(ProductModel.fromSnapshot(product));
      }
    } catch (e) {
      print("list error $e");
    }
    return products;
  }

  List<ProductModel> getProducts() {
    List<ProductModel> products = [];
    _firestore.collection(_tableName).get().then((result) {
      for (DocumentSnapshot product in result.docs) {
        products.add(ProductModel.fromSnapshot(product));
      }
    });
    return products;
  }

  Future<List<ProductModel>> getProductByName(String value) async {
    List<ProductModel> products = [];
    await _firestore
        .collection(_tableName)
        .where('name', isEqualTo: value)
        .get()
        .then((result) {
      for (DocumentSnapshot product in result.docs) {
        products.add(ProductModel.fromSnapshot(product));
      }
    });
    return products;
  }
}
