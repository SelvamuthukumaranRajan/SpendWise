import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/models/auth_user_model.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    int retries = 3;
    for (int attempt = 0; attempt < retries; attempt++) {
      try {
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User? user = result.user;
        return user;
      } catch (e) {
        if (e.toString().contains('[cloud_firestore/unavailable]')) {
          print('Firestore is unavailable, retrying...');
          await Future.delayed(Duration(seconds: 2 * (attempt + 1)));
        } else {
          print(e.toString());
          return null;
        }
      }
    }
    return null;
  }


  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e, stackTrace) {
      print("Register : ${e.toString()} && ${stackTrace.toString()}");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> createUser(AuthUserModel user) async {
    try {
      return await _db.collection('users').doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'balance': user.balance,
      });
    } catch (e) {
      print("CreateUser : ${e.toString()}");
      return;
    }
  }

  Future<AuthUserModel?> getUserDetails(String uid) async {
    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return AuthUserModel(
        uid: uid,
        name: doc['name'],
        email: doc['email'],
        password: doc['password'],
        balance: doc['balance'],
      );
    }
    return null;
  }
}
