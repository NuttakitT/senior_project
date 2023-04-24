import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// The FirebaseServices containts CRUD operations and
// database listener for using with real-time change.
// To use: create an FirebaseServices object and
// send collectionName as pareameter.
class FirebaseServices {
  late CollectionReference _collection;

  FirebaseServices(String collectionName) {
    _collection = FirebaseFirestore.instance.collection(collectionName);
  }

  //------------------------ Create orperation ---------------------------------
  // Create a document to the target collection, using docId as
  // a document's id. If has error, return false, otherwise true.
  // docId: String to use as document's id.
  // detail: data, in Map structre, to store in database.
  Future<bool> setDocument(String docId, Map<String, dynamic> detail) async {
    try {
      await _collection.doc(docId).set(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Create a document to the target collection, using firebase
  // auto-generated as a document's id. If has error, return false,
  // otherwise true.
  // detail: data, in Map structre, to store in database.
  Future<bool> addDocument(Map<String, dynamic> detail) async {
    try {
      await _collection.add(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  //---------------------------- Update operation ------------------------------
  // Update data in the document that has a matching ID. If has error,
  // return false, otherwise true.
  // docId: ID of the document to update data.
  // detail: data, in Map structure, to update(send only updated filed).
  Future<bool> editDocument(String docId, Map<String, dynamic> detail) async {
    try {
      await _collection.doc(docId).update(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  //---------------------------- Read operation --------------------------------
  // Get a document form the collection that has a matching ID.
  // If there is no requested document in databse, return null.
  // id: an id of the targte documnet.
  Future<DocumentSnapshot?> getDocumentById(String id) async {
    try {
      return await _collection.doc(id).get();
    } catch (e) {
      return null;
    }
  }

  Future<QuerySnapshot?> getDocumentByKeyList(
      String key, List<dynamic> list) async {
    try {
      return await _collection.where(key, arrayContainsAny: list).get();
    } catch (e) {
      return null;
    }
  }

  // Query documnets in the collection, using key-value to query.
  // If there are no any documents, return null.
  // key: list of the filed to query
  // value: list of the value to query
  // key and value must have the same length and in th same index
  // refers to one pair of the key-value.
  //
  // Optional parameters
  // limit: number of query result
  // orderingField: ordering result by target string
  // descending: ordering type
  Future<QuerySnapshot?> getDocumnetByKeyValuePair(
      List<String> key, List<dynamic> value,
      {int? limit,
      String? orderingField,
      DocumentSnapshot? startDoc,
      bool descending = false}) async {
    try {
      late Query query;

      if ((key.length == value.length) && key.isNotEmpty) {
        for (int i = 0; i < key.length; i++) {
          if (i != 0) {
            if (value[i] is List) {
              query = query.where(key[i], arrayContainsAny: value[i]);
            } else {
              query = query.where(key[i], isEqualTo: value[i]);
            }
          } else {
            if (value[i] is List) {
              query = _collection.where(key[i], arrayContainsAny: value[i]);
            } else {
              query = _collection.where(key[i], isEqualTo: value[i]);
            }
          }
        }
      }
      if (orderingField != null) {
        query = query.orderBy(orderingField, descending: descending);
      }
      if (limit != null) {
        query = query.limit(limit);
      }
      if (startDoc != null) {
        query = query.startAfterDocument(startDoc);
      }
      return await query.get();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // TODO add change to report
  // Get all documents in the collection, return null there are no
  // document or collection in the database.
  Future<QuerySnapshot?> getAllDocument({String? orderingField, bool descending = false}) async {
    try {
      if (orderingField != null) {
        return await _collection.orderBy(orderingField, descending: descending).get();
      }
      return await _collection.get();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  // TODO add change to report
  //---------------------- Read operation(Real-time) ---------------------------
  // A stream listener use as a listener for a document queried by key-value.
  // key: list of the filed to query
  // value: list of the value to query
  // key and value must have the same length and in th same index
  // refers to one pair of the key-value.
  //
  // Optional parameters
  // limit: number of query result
  // orderingField: ordering result by target string
  // descending: ordering type
  // afterDoc: start query result after target document
  Stream<QuerySnapshot?> listenToDocumentByKeyValuePair(
      List<String> key, List<dynamic> value,
      {int? limit,
      String? orderingField,
      bool descending = false,
      DocumentSnapshot? startDoc,
      bool isReverse = false}) {
    late Query query;
    if ((key.length == value.length) && key.isNotEmpty) {
      for (int i = 0; i < key.length; i++) {
        if (i != 0) {
          if (key[i] == "adminId") {
            query = query.where(key[i], arrayContainsAny: [value[i]]);
          } else {
            query = query.where(key[i], isEqualTo: value[i]);
          }
        } else {
          if (key[i] == "adminId") {
            query = _collection.where(key[i], arrayContainsAny: [value[i]]);
          } else {
            query = _collection.where(key[i], isEqualTo: value[i]);
          }
        }
      }
    }
    if (orderingField != null) {
      query = query.orderBy(orderingField, descending: descending);
    }
    if (limit != null) {
      query = query.limit(limit);
    }
    if (startDoc != null) {
      if (isReverse) {
        query = query.startAtDocument(startDoc);
      } else {
        query = query.startAfterDocument(startDoc);
      }
    }
    return query.snapshots();
  }

  Future<QuerySnapshot?> getDocumentByDateInterval(
      DateTime from, DateTime to) async {
    try {
      return await _collection
          .where('dateCreate', isGreaterThanOrEqualTo: from)
          .where('dateCreate', isLessThanOrEqualTo: to)
          .orderBy('dateCreate')
          .get();
    } catch (e) {
      return null;
    }
  }

  // Return a stream listener used as a listener in the collection
  Stream<QuerySnapshot> listenToallDocument() {
    return _collection.snapshots();
  }

  Stream<DocumentSnapshot> listenToDocument(String docId) {
    return _collection.doc(docId).snapshots();
  }

  //---------------------------- Delete operation ------------------------------
  // Delete the document that has a matching ID in the collection.
  // If has error, return false, otherwise true.
  // docId: ID of the target document.
  Future<bool> deleteDocument(String docId) async {
    try {
      await _collection.doc(docId).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  //**************************** Sub-collection ********************************

  //------------------------ Create orperation ---------------------------------
  // Create a document to the sub-collection of target document, using firebase
  // auto-generated as a document's id. If has error, return false,
  // otherwise true.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // detail: data, in Map structre, to store in database.
  Future<bool> addSubDocument(String parentId, String subCollectionName,
      Map<String, dynamic> detail) async {
    try {
      _collection.doc(parentId).collection(subCollectionName).add(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Create a document to the sub-collection of target document, using sunId as
  // a document's id. If has error, return false, otherwise true.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // subId: String to use as document's id.
  // detail: data, in Map structre, to store in database.
  Future<bool> setSubDocument(String parentId, String subCollectionName,
      String subId, Map<String, dynamic> detail) async {
    try {
      await _collection
          .doc(parentId)
          .collection(subCollectionName)
          .doc(subId)
          .set(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  //--------------------------- Update Operation -------------------------------
  // Update data in the document of the sub-collection
  // that has a matching ID. If has error, return false, otherwise true.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // subId: ID of the target document.
  // detail: data, in Map structure, to update(send only updated filed).
  Future<bool> editSubDocument(String parentId, String subCollectionName,
      String subId, Map<String, dynamic> detail) async {
    try {
      await _collection
          .doc(parentId)
          .collection(subCollectionName)
          .doc(subId)
          .update(detail);
      return true;
    } catch (e) {
      return false;
    }
  }

  //---------------------------- Delete operation ------------------------------
  // Delete the document in the sub-collection that has a matching ID.
  // If has error, return false, otherwise true.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // subId: ID of the target document.
  Future<bool> deleteSubDocument(
    String parentId,
    String subCollectionName,
    String subId,
  ) async {
    try {
      await _collection
          .doc(parentId)
          .collection(subCollectionName)
          .doc(subId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  //---------------------------- Read operation --------------------------------
  // Get a document form the sub-collection that has a matching ID.
  // If there is no requested document in databse, return null.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // subId: ID of the target document.
  Future<DocumentSnapshot?> getSubDocumentById(
    String parentId,
    String subCollectionName,
    String subId,
  ) async {
    try {
      return await _collection
          .doc(parentId)
          .collection(subCollectionName)
          .doc(subId)
          .get();
    } catch (e) {
      return null;
    }
  }

  // Query documnets in the collection, using key-value to query.
  // If there are no any documents, return null.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // key: list of the filed to query
  // value: list of the value to query
  // key and value must have the same length and in th same index
  // refers to one pair of the key-value.
  Future<QuerySnapshot?> getSubDocumnetByKeyValuePair(
    String parentId,
    String subCollectionName,
    List<String> key,
    List<dynamic> value,
  ) async {
    try {
      late Query query;
      if ((key.length == value.length) && key.isNotEmpty) {
        for (int i = 0; i < key.length; i++) {
          if (i != 0) {
            query = query.where(key[i], isEqualTo: value[i]);
          } else {
            query = _collection
                .doc(parentId)
                .collection(subCollectionName)
                .where(key[i], isEqualTo: value[i]);
          }
        }
      }
      return await query.get();
    } catch (e) {
      return null;
    }
  }

  // Get all documents in the sub-collection, return null there are no
  // document or collection in the database.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  Future<QuerySnapshot?> getAllSubDocument(
    String parentId,
    String subCollectionName,
  ) async {
    try {
      return await _collection
          .doc(parentId)
          .collection(subCollectionName)
          .get();
    } catch (e) {
      return null;
    }
  }

  // TODO add change to report
  //---------------------- Read operation(Real-time) ---------------------------
  // A stream listener used as a listener for a document in sub-collection
  // queried by key-value.
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  // key: list of the filed to query
  // value: list of the value to query
  // key and value must have the same length and in th same index
  // refers to one pair of the key-value.
  Stream<QuerySnapshot?> listenToSubDocumentByKeyValuePair(
    String parentId,
    String subCollectionName,
    List<String> key,
    List<dynamic> value,
  ) {
    Query? query;
    if ((key.length == value.length) && key.isNotEmpty) {
      for (int i = 0; i < key.length; i++) {
        if (query != null) {
          if (value[i] is List) {
            query = query.where(key[i], arrayContainsAny: value[i]);
          } else {
            query = query.where(key[i], isEqualTo: value[i]);
          }
        } else {
          if (value[i] is List) {
            query = _collection
                .doc(parentId)
                .collection(subCollectionName)
                .where(key[i], arrayContainsAny: value[i]);
          } else {
            query = _collection
                .doc(parentId)
                .collection(subCollectionName)
                .where(key[i], isEqualTo: value[i]);
          }
        }
      }
    }
    return query!.snapshots();
  }

  // Return a stream listener used as a listener in the sub-collection
  // parentId: String of the parent(top-level) document
  // subCollectionName: name of the collection
  Stream<QuerySnapshot> listenToSubDocument(
      String parentId, String subCollectionName,
      {String? orderingField, bool descending = false}) {
    Query? query;
    try {
      query = _collection.doc(parentId).collection(subCollectionName);
      if (orderingField != null) {
        query = query.orderBy(orderingField, descending: descending);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return query!.snapshots();
  }
}
