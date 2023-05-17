import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class FacilityViewModel extends ChangeNotifier {
  final _roomService = FirebaseServices("rooms");
  final _itemService = FirebaseServices("items");
  final _itemReservation = FirebaseServices("itemReservations");
  List<ItemModel> _items = [];
  RoomModel? roomFromRaioForm;

  get getViewModeItems => _items;
  void clearItems() => _items = [];

  void setSelectedRooms(RoomModel room) {
    roomFromRaioForm = room;
  }

  Future<List<RoomModel>> getAvailableRoom(DateTime? date, DateTime? time) async {
    try {
      List<RoomModel> rooms = [];
      if (date != null && time != null) {
        final roomSnapshot = await _roomService.getAllDocument(
          orderingField: "name"
        );
        for (int i = 0; i < roomSnapshot!.docs.length; i++) {
          final reservationSnapshot = await _roomService.getSubDocumnetByKeyValuePair(
            roomSnapshot.docs[i].id, 
            "reservations", 
            ["bookTime"], 
            [combineDateTime(date, time)]
          );
          if (reservationSnapshot!.size == 0) {
            rooms.add(RoomModel
              (
                name: roomSnapshot.docs[i].get("name"), 
                type: roomSnapshot.docs[i].get("type"), 
                capacity: roomSnapshot.docs[i].get("capacity"), 
              )
            );
          }
        }
      }
      return rooms;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  Future<bool> reserveRoom(RoomReservationRequest request) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .where('name', isEqualTo: roomFromRaioForm?.name)
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

  Future<List<ItemModel>> getItems() async {
    final snapshot = await _itemService.getAllDocument();

    List<ItemModel> items = [];

    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      ItemModel item = ItemModel(objectName: doc['objectName']);
      items.add(item);
    }
    return items;
  }

  Future<bool> requestBookings() async {
    return true;
  }

  Future<Booking> fetchBooking(String userId) async {
    final itemSnapshot =
        await _itemReservation.getDocumentByKeyList("userId", [userId]);
    final roomSnapshot = await _roomService.getAllDocument();

    final Booking booking = Booking(roomRes: [
      RoomReservation(
          purpose: "purpose",
          dateCreate: DateTime.now(),
          bookTime: DateTime.now(),
          userId: userId,
          status: "Approved",
          room: "CPE1111"),
      RoomReservation(
          purpose: "purpose",
          dateCreate: DateTime.now(),
          bookTime: DateTime.now(),
          userId: userId,
          status: "Approved",
          room: "CPE1112"),
    ], itemRes: [
      ItemReservation(
          objectName: "objectName",
          purpose: "purose",
          amount: 3,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          userId: userId,
          status: "Approve"),
      ItemReservation(
          objectName: "Dog",
          purpose: "purose",
          amount: 3,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          userId: userId,
          status: "Approve"),
      ItemReservation(
          objectName: "Cat",
          purpose: "purose",
          amount: 3,
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          userId: userId,
          status: "Approve"),
    ]);
    return booking;
  }
}
