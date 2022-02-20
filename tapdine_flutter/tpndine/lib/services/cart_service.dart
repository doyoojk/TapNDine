import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final firestoreInstance = FirebaseFirestore.instance;

  void uploadCartFirestore(Map<String, dynamic> uploadMap) {
    firestoreInstance
        .collection("orders")
        .add(uploadMap)
        .then((value) => print(value.id));
  }
}
