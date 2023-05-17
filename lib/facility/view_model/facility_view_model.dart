import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

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

  Future<List<RoomModel>> getAvailableRoom(
      DateTime? date, DateTime? time) async {
    try {
      List<RoomModel> rooms = [];
      if (date != null && time != null) {
        final roomSnapshot =
            await _roomService.getAllDocument(orderingField: "name");
        for (int i = 0; i < roomSnapshot!.docs.length; i++) {
          final reservationSnapshot = await _roomService
              .getSubDocumnetByKeyValuePair(roomSnapshot.docs[i].id,
                  "reservations", ["bookTime"], [combineDateTime(date, time)]);
          if (reservationSnapshot!.size == 0) {
            rooms.add(RoomModel(
              name: roomSnapshot.docs[i].get("name"),
              type: roomSnapshot.docs[i].get("type"),
              capacity: roomSnapshot.docs[i].get("capacity"),
            ));
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

  Future<void> getItems() async {
    final snapshot = await _itemService.getAllDocument();
    for (QueryDocumentSnapshot doc in snapshot!.docs) {
      ItemModel item = ItemModel(objectName: doc['objectName']);
      List<ItemModel> hasItemList = _items
          .where((element) => element.objectName == doc["objectName"])
          .toList();
      if (hasItemList.isEmpty) {
        _items.add(item);
      }
    }
  }

  Future<bool> requestItems(ItemReservation request, List<dynamic> ticket,
      BuildContext context) async {
    final ticketId = await context
        .read<HelpDeskViewModel>()
        .createTask(ticket[0], ticket[1], ticket[2], ticket[3]);
    final userId = context.read<AppViewModel>().app.getUser.getId;

    Map<String, dynamic> itemData = {
      'objectName': request.objectName,
      'amount': request.amount,
      'startDate': Timestamp.fromDate(request.startDate),
      'endDate': Timestamp.fromDate(request.endDate),
      'purpose': request.purpose,
      'status': "Pending",
      'userId': userId,
      'ticketId': ticketId
    };
    final result = await _itemReservation.addDocument(itemData);

    return result;
  }

  Future<List<RoomReservation>> fetchMyRoomReservation() async {
    List<RoomReservation> list = [];
    final roomSnapshot = await _roomService.getAllDocument();

    return list;
  }

  Future<List<ItemReservation>> fetchMyItemReservations(String userId) async {
    final snapshot =
        await _itemReservation.getDocumentByKeyList("userId", [userId]);

    List<ItemReservation> list = [];

    return list;
  }

  Future<Booking> fetchBooking(String userId) async {
    final itemRes = await fetchMyItemReservations(userId);
    final roomRes = await fetchMyRoomReservation();
    final booking = Booking(roomRes: roomRes, itemRes: itemRes);
    // final Booking booking = Booking(roomRes: [
    //   RoomReservation(
    //       purpose: "purpose",
    //       dateCreate: DateTime.now(),
    //       bookTime: DateTime.now(),
    //       userId: userId,
    //       status: "Approved",
    //       room: "CPE1111"),
    //   RoomReservation(
    //       purpose: "purpose",
    //       dateCreate: DateTime.now(),
    //       bookTime: DateTime.now(),
    //       userId: userId,
    //       status: "Approved",
    //       room: "CPE1112"),
    // ], itemRes: [
    //   ItemReservation(
    //       objectName: "objectName",
    //       purpose: "purose",
    //       amount: 3,
    //       startDate: DateTime.now(),
    //       endDate: DateTime.now(),
    //       userId: userId,
    //       status: "Approve"),
    //   ItemReservation(
    //       objectName: "Dog",
    //       purpose: "purose",
    //       amount: 3,
    //       startDate: DateTime.now(),
    //       endDate: DateTime.now(),
    //       userId: userId,
    //       status: "Approve"),
    //   ItemReservation(
    //       objectName: "Cat",
    //       purpose: "purose",
    //       amount: 3,
    //       startDate: DateTime.now(),
    //       endDate: DateTime.now(),
    //       userId: userId,
    //       status: "Approve"),
    // ]);
    return booking;
  }

  Future<void> cancelBooking() async {}

  // เพิ่มรายงานการจองห้อง ในแง่ของ เลขห้อง วันเวลา
  Future<void> fetchRoomStatisticData() async {}
}
