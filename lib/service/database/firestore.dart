import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of orders
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  //get user data from register
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  // hash password
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // save order to db firestore
  Future<void> saveOrderToDatabase(String receipt) async {
    await orders.add({
      'createdAt': DateTime.now(),
      'receipt': receipt,
      // add more fields here if needed
    });
  }

  // save user data to db firestore
  Future<void> saveUserDataToDatabase(
      String name, String email, String password) async {
    await users.add(
      {
        'createdAt': DateTime.now(),
        'name': name,
        'email': email,
        'password': hashPassword(password),
        // add more fields here if needed
      },
    );
  }
}
