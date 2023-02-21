import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  late CollectionReference _collection;

  FirebaseServices(String collectionName) {
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  Future<bool> setDocument(String docId, Map<String, dynamic> detail) async {
    try {
      await _collection.doc(docId).set(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addDocument(Map<String, dynamic> detail) async {
    try {
      await _collection.add(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> editDocument(String docId, Map<String, dynamic> detail) async {
    try {
      await _collection.doc(docId).update(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DocumentSnapshot?> getDocumentById(String id) async {
    try {
      return await _collection.doc(id).get();
    } catch (e) {
      return null;
    }   
  }

  Future<QuerySnapshot?> getDocumnetByKeyValuePair(
    List<String> key, 
    List<String> value, 
  ) async {
    try {
      late Query query;
      if ((key.length == value.length) && key.isNotEmpty) {
        for (int i = 0; i < key.length; i++) {
          query = _collection.where(key[i], isEqualTo: value[i]);
        }
      }
      return await query.get();
    } catch (e) {
      return null;
    }
  }

  Future<QuerySnapshot?> getAllDocument() async {
    try {
      return await _collection.get();
    } catch (e) {
      return null;
    } 
  }

  Stream<QuerySnapshot?> listenToDocumentByKeyValuePair(
    List<String> key, 
    List<dynamic> value
  )  {
    late Query query;
    if ((key.length == value.length) && key.isNotEmpty) {
      for (int i = 0; i < key.length; i++) {
        query = _collection.where(key[i], isEqualTo: value[i]);
      }
    }
    return query.snapshots();
  }
  
  Stream<DocumentSnapshot?> listenToDocumentId(String docId) {
    return _collection.doc(docId).snapshots();
  }

  Stream<QuerySnapshot> listenToDocument() {
    return _collection.snapshots();
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