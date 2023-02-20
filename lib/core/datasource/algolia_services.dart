import 'package:algolia/algolia.dart';

class AlgoliaServices {
  late final AlgoliaIndexReference _algolia;

  AlgoliaServices(String index) {
    _algolia = const Algolia.init(
      applicationId: "LEPUBBA9NX", 
      apiKey: "de19f0a0ad7c0137ef4adb4245ac5d5b"
    ).instance.index(index);
  }

  Future<String?> addObject(
    String docId,
    Map<String, dynamic> detail
  ) async {
    try {
      detail.addAll({"docId": docId});
      final object =await _algolia.addObject(detail);
      return object.data["objectID"];
    } catch (e) {
      return null;
    }
  }

  Future<bool> updateObject(
    String objecId, 
    Map<String, dynamic> detail
  ) async {
    try {
      final object = await _algolia.object(objecId).getObject();
      Map<String, dynamic> updateData = Map<String, dynamic>.from(object.data);
      updateData.addAll(detail);
      await _algolia.object(objecId).updateData(updateData);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteObject(String objectId) async {
    try {
      await _algolia.object(objectId).deleteObject();
      return true;
    } catch (e) {
      return false;
    }
  } 

  Future<List<Map<String, dynamic>>> queryObject(String text) async {
    List<Map<String, dynamic>> result = [];
    var query = await _algolia.query(text).getObjects();
    for (int i = 0; i < query.nbHits; i++) {
      print(query.hits[0].data["title"]);
      result.add(query.hits[0].data);
    }
    return result;
  }
}