import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandServices {
  // Generate a v1 (time-based) id
  String _brandId = Uuid().v1();
  String _tableName = 'Brands';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void createBrand(String name) {
    _firestore.collection(_tableName).doc(_brandId).set({'BrandName': name});
  }

  Future<List<DocumentSnapshot>> getBrands() async {
    return await _firestore.collection(_tableName).get().then((value) {
      print(value); //Instance of 'QuerySnapshot'
      print(value.docs); //[Instance of 'QueryDocumentSnapshot']
      return value.docs;
    });
  }
}
