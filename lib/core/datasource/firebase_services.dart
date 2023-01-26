import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  late CollectionReference _collection;

  FirebaseServices(String collectionName) {
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  Future<bool> addDocument(Map<String, dynamic> detail) async {
    try {
      await _collection.add(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> editDocument(String docId, Map<String, dynamic> detail) async {
    await _collection.doc(docId).update(detail);
  }

  Future<QuerySnapshot> getDocumentByKeyValue(String key, String value) async {
    return await _collection.where(key, isEqualTo: value).get();
  }

  Future<bool> deleteDocument(String docId) async {
    try {
      await _collection.doc(docId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}