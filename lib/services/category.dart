import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryServices {
  // Generate a v1 (time-based) id
  String _categoryId = Uuid().v1();
  String _tableName = 'Categories';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void createCategory(String name) {
    _firestore
        .collection('Categories')
        .doc(_categoryId)
        .set({'categoryName': name});
  }

  Future<List<DocumentSnapshot>> getCategories() async {
    return await _firestore.collection(_tableName).get().then((value) {
      // print(value); //Instance of 'QuerySnapshot'
      // print(value.docs); //[Instance of 'QueryDocumentSnapshot']
      return value.docs;
    });
  }
}
