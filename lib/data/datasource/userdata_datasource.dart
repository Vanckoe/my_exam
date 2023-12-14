import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_market/domain/entities/userdata_entities.dart';


class UserDataSource {
  final FirebaseFirestore firestore;

  UserDataSource({required this.firestore});

  Future<void> createUser(AppUser user) async {
    await firestore.collection('users').doc(user.email).set(user.toMap());
  }
   Future<DocumentSnapshot> getUserData(String email) async {
    return await firestore.collection('users').doc(email).get();
  }
}
