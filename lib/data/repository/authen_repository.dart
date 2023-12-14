import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_market/data/datasource/userdata_datasource.dart';
import 'package:flutter_market/domain/entities/userdata_entities.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final UserDataSource userDataSource;

  AuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    required this.userDataSource,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  Future<void> signInWithCredentials(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUp(AppUser user, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: password);
    await userDataSource.createUser(user);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
  
}
