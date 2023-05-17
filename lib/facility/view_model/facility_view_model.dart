import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class FacilityViewModel extends ChangeNotifier {
  final _roomService = FirebaseServices("rooms");
  final _itemService = FirebaseServices("items");
  final _itemReservation = FirebaseServices("itemReservations");
  List<ItemModel> _items = [];

  get getViewModeItems => _items;
  void clearItems() => _items = [];

  Future<List<RoomModel>> getAvailableRoom() async {
    final rooms = [
      RoomModel(name: "CPE 1111", capacity: 20, type: "Lecture Room"),
      RoomModel(name: "CPE 1112", capacity: 25, type: "Lecture Room"),
      RoomModel(name: "CPE 1113", capacity: 30, type: "Lecture Room"),
    ];
    return rooms;
  }

  Future<bool> reserveRoom(RoomReservationRequest request) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .where('name', isEqualTo: request.room)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return false;
    }
    final roomId = snapshot.docs.first.id;

    Map<String, dynamic> reservationData = {
      'purpose': request.purpose,
      'dateCreate': Timestamp.now(),
      'bookTime': Timestamp.fromDate(
          combineDateTime(request.bookDate, request.bookTime)),
      'userId': request.userId,
      'status': "Approve",
    };

    await _roomService.addSubDocument(roomId, "reservations", reservationData);
    return true;
  }

  DateTime combineDateTime(DateTime date, DateTime time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }

  Future<void> getItems() async {
    final snapshot = await _itemService.getAllDocument();
    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      ItemModel item = ItemModel(objectName: doc['objectName']);
      List<ItemModel> hasItemList = _items.where((element) => element.objectName == doc["objectName"]).toList();
      if (hasItemList.isEmpty) {
        _items.add(item);
      }
    }
  }

  Future<bool> requestBookings() async {
    return true;
  }

  Future<Booking> fetchBookings() async {
    final bookings = Booking(roomRes: [], itemRes: []);
    return bookings;
  }
}
