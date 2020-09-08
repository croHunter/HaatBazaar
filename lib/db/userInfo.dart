import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserInfoService {
  // Generate a v1 (time-based) id
  String _userId = Uuid().v1();
  String _tableName = 'UserInfo';

  DateTime date = DateTime.now();

  //String joinedDate = '$day $month $year';
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void createUser(String name, String phone, String password, String location) {
    _firestore.collection(_tableName).doc(_userId).set({
      'Full name': name,
      'Phone': phone,
      'Password': password,
      'Joined Date': date,
      'Location': location,
    });
  }
}
