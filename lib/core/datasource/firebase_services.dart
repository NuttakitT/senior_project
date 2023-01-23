import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  late CollectionReference _collection;

  FirebaseServices(String collectionName) {
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  Future<bool> addDocument(Map<String, String> detail) async {
    try {
      await _collection.add(detail);
      return true;
    } catch (e) {
      return false;
    }
  }
}