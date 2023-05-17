import 'package:flutter/material.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class FacilityViewModel extends ChangeNotifier {
  Future<List<RoomModel>> getAvailableRoom() async {
    final rooms = [
      RoomModel(name: "CPE 1111", capacity: 20, type: "Lecture Room"),
      RoomModel(name: "CPE 1112", capacity: 25, type: "Lecture Room"),
      RoomModel(name: "CPE 1113", capacity: 30, type: "Lecture Room"),
    ];
    return rooms;
  }

  Future<List<ItemModel>> getItems() async {
    final items = [
      ItemModel(objectName: "objectName"),
      ItemModel(objectName: "cat"),
      ItemModel(objectName: "objectName3"),
      ItemModel(objectName: "objectName4"),
      ItemModel(objectName: "objectName5"),
      ItemModel(objectName: "objectName6"),
    ];

    return items;
  }
}
