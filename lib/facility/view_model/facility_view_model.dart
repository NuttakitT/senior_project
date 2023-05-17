import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class FacilityViewModel extends ChangeNotifier {
  final _roomService = FirebaseServices("rooms");
  final _itemService = FirebaseServices("items");
  final _itemReservation = FirebaseServices("itemReservations");

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

  Future<List<BookingCard>> fetchBookings(String userId) async {
    final itemSnapshot =
        await _itemReservation.getDocumentByKeyList("userId", [userId]);
    final roomSnapshot = await _roomService.getAllDocument();

    final List<BookingCard> list = [
      BookingCard(
          title: "title",
          detail: "detail",
          createTime: "time",
          requestTime: "time",
          status: "status"),
      BookingCard(
          title: "title",
          detail: "detail",
          createTime: "time",
          requestTime: "time",
          status: "status"),
      BookingCard(
          title: "title",
          detail: "detail",
          createTime: "time",
          requestTime: "time",
          status: "status"),
    ];
    return list;
  }
}
