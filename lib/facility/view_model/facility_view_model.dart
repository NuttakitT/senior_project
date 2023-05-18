import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/facility/model/facility_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:uuid/uuid.dart';

class FacilityViewModel extends ChangeNotifier {
  final _roomService = FirebaseServices("rooms");
  final _itemService = FirebaseServices("items");
  final _itemReservation = FirebaseServices("itemReservations");
  final _scheduleService = FirebaseServices("schedule");
  List<ItemModel> _items = [];
  RoomModel? roomFromRaioForm;

  get getViewModeItems => _items;
  void clearItems() => _items = [];

  void setSelectedRooms(RoomModel room) {
    roomFromRaioForm = room;
  }

  String getUuid() {
    return const Uuid().v1();
  }

  Future<List<RoomModel>> getAllRooms() async {
    final roomSnapshot =
        await _roomService.getAllDocument(orderingField: "name");
    List<RoomModel> list = [];
    for (int i = 0; i < roomSnapshot!.docs.length; i++) {
      list.add(RoomModel(
        name: roomSnapshot.docs[i].get("name"),
        type: roomSnapshot.docs[i].get("type"),
        capacity: roomSnapshot.docs[i].get("capacity"),
      ));
    }
    return list;
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
            // start check schedules
            List<Schedule> schedules = [];
            final scheduleSnapshot = await _scheduleService
                .getDocumnetByKeyValuePair(["roomName", "dayOfWeek"],
                    [roomSnapshot.docs[i].get("name"), date.weekday]);
            if (scheduleSnapshot!.size != 0) {
              for (int i = 0; i < scheduleSnapshot.docs.length; i++) {
                Timestamp startTime = scheduleSnapshot.docs[i].get("startTime");
                Timestamp endTime = scheduleSnapshot.docs[i].get("endTime");

                schedules.add(Schedule(
                    roomName: scheduleSnapshot.docs[i].get("roomName"),
                    dayOfWeek: scheduleSnapshot.docs[i].get("dayOfWeek"),
                    startTime: startTime.toDate(),
                    endTime: endTime.toDate()));
              }
            }
            // end check schedules

            if (await checkScheduleCanUserReserve(time, schedules)) {
              rooms.add(RoomModel(
                name: roomSnapshot.docs[i].get("name"),
                type: roomSnapshot.docs[i].get("type"),
                capacity: roomSnapshot.docs[i].get("capacity"),
              ));
            }
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

  Future<bool> checkScheduleCanUserReserve(
      DateTime time, List<Schedule> schedules) async {
    if (schedules.isEmpty) {
      return true;
    }
    for (Schedule sch in schedules) {
      DateTime startTime =
          DateTime(time.year, time.month, time.day, sch.startTime.hour);
      DateTime endTime =
          DateTime(time.year, time.month, time.day, sch.endTime.hour);
      bool isAfterStartTime = time.isAfter(startTime);
      bool isTheSameAsStartTime = time.isAtSameMomentAs(startTime);
      bool isBeforeEndTime = time.isBefore(endTime);
      if ((isAfterStartTime && isBeforeEndTime) || isTheSameAsStartTime) {
        return false;
      }
    }
    return true;
  }

  Future<bool> scheduleRoom(Schedule request) async {
    final id = getUuid();
    Map<String, dynamic> data = {
      'id': id,
      'roomName': roomFromRaioForm?.name,
      'dayOfWeek': request.dayOfWeek,
      'startTime': Timestamp.fromDate(request.startTime),
      'endTime': Timestamp.fromDate(request.endTime),
    };
    final result = await _scheduleService.addDocument(data);
    return result;
  }

  Future<List<Schedule>> getAllSchedule() async {
    List<Schedule> list = [];
    final snapshot =
        await _scheduleService.getAllDocument(orderingField: "roomName");
    if (snapshot!.size != 0) {
      for (int i = 0; i < snapshot.docs.length; i++) {
        Timestamp startTime = snapshot.docs[i].get("startTime");
        Timestamp endTime = snapshot.docs[i].get("endTime");

        list.add(Schedule(
            id: snapshot.docs[i].get("id"),
            roomName: snapshot.docs[i].get("roomName"),
            dayOfWeek: snapshot.docs[i].get("dayOfWeek"),
            startTime: startTime.toDate(),
            endTime: endTime.toDate()));
      }
    }

    return list;
  }

  Future<void> deleteSchedule(String id) async {
    await _scheduleService.deleteDocument(id);
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
    final docId = getUuid();

    Map<String, dynamic> reservationData = {
      'id': docId,
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
    return booking;
  }

  Future<void> cancelBooking() async {}

  // เพิ่มรายงานการจองห้อง ในแง่ของ เลขห้อง วันเวลา
  Future<void> fetchRoomStatisticData() async {}
}