import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haatbazaar/model/usermodel.dart';

import '../model/cartitemmodel.dart';

class UserInfoService {
  // Generate a v1 (time-based) id
  //String _userId = Uuid().v1();
  String _tableName = 'UserInfo';

  //DateTime date = DateTime.now();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createUser(String uId, String name, String phone,
      String password, String location, DateTime joinedDate) async {
    print('create user table');
    await _firestore.collection(_tableName).doc(uId).set({
      'User Id': uId,
      'Full name': name,
      'Phone': phone,
      'Password': password,
      'Joined Date': joinedDate,
      'Location': location,
    });
  }

  bool verifyPassword(String password) {
    return true;
  }

  Future<UserModel> getUserById(String id) async =>
      await _firestore.collection(_tableName).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  Future<void> addToCart({String userId, CartItemModel cartItem}) async {
    await _firestore.collection(_tableName).doc(userId).update({
      "cart": FieldValue.arrayUnion([
        cartItem.toMap()
      ]) //again mapping to the database of field cart(it has an arrayUnion) which is created just now !!|||creation of cart field
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    _firestore.collection(_tableName).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }
}
