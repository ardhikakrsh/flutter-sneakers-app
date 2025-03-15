import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of orders
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  // save order to db firestore
  Future<void> saveOrderToDatabase(String receipt) async {
    await orders.add({
      'createdAt': DateTime.now(),
      'receipt': receipt,
      // add more fields here if needed
    });
  }
}
