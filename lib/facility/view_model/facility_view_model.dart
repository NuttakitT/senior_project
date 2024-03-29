// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime endDate = DateTime.now();

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
      DateTime? date, DateTime? time, DateTime? endTime) async {
    try {
      List<RoomModel> rooms = [];
      if (date != null && time != null) {
        final roomSnapshot =
            await _roomService.getAllDocument(orderingField: "name");
        for (int i = 0; i < roomSnapshot!.docs.length; i++) {
          // final reservationSnapshot = await _roomService
          //     .getSubDocumnetByKeyValuePair(roomSnapshot.docs[i].id,
          //         "reservations", ["bookTime"], [combineDateTime(date, time)]);
          DateTime startTime = combineDateTime(date, time);
          endTime = combineDateTime(date, endTime!);
          // startTime in range of resevaed room
          final endTimeRangeSnapshot = await FirebaseFirestore
            .instance
            .collection("rooms")
            .doc(roomSnapshot.docs[i].id)
            .collection("reservations")
            // .where("bookTime", isLessThanOrEqualTo: startTime)
            .where("endTime", isGreaterThan: startTime)
            .get();
          final startTimeRangeSnapshot = await FirebaseFirestore
            .instance
            .collection("rooms")
            .doc(roomSnapshot.docs[i].id)
            .collection("reservations")
            .where("bookTime", isLessThanOrEqualTo: startTime)
            .get();
          // endTime in range of reserved room
          final endTimeCheckSnapshot = await FirebaseFirestore
            .instance
            .collection("rooms")
            .doc(roomSnapshot.docs[i].id)
            .collection("reservations")
            .where("bookTime", isLessThan: endTime)
            .get();
          final endTimeCheckSnapshot2 = await FirebaseFirestore
            .instance
            .collection("rooms")
            .doc(roomSnapshot.docs[i].id)
            .collection("reservations")
            .where("endTime", isGreaterThan: endTime)
            .get();
          if ((endTimeRangeSnapshot.size == 0 || startTimeRangeSnapshot.size == 0) && (endTimeCheckSnapshot.size == 0 || endTimeCheckSnapshot2.size == 0)) {
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
      DateTime startTime = DateTime(time.year, time.month, time.day,
          sch.startTime.hour, sch.startTime.minute);
      DateTime endTime = DateTime(time.year, time.month, time.day,
          sch.endTime.hour, sch.endTime.minute);
      DateTime endTimeBooking =
          DateTime(time.year, time.month, time.day, time.hour + 1, 20);
      bool isAfterStartTime =
          time.isAfter(startTime) || endTimeBooking.isAfter(startTime);
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
            id: snapshot.docs[i].id,
            roomName: snapshot.docs[i].get("roomName"),
            dayOfWeek: snapshot.docs[i].get("dayOfWeek"),
            startTime: startTime.toDate(),
            endTime: endTime.toDate()));
      }
    }

    return list;
  }

  Future<void> deleteSchedule(String id) async {
    try {
      await _scheduleService.deleteDocument(id);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
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
    final docId = getUuid();

    Map<String, dynamic> reservationData = {
      'id': docId,
      'purpose': request.purpose,
      'dateCreate': Timestamp.now(),
      'bookTime': Timestamp.fromDate(
          combineDateTime(request.bookDate, request.bookTime)),
      'endTime': Timestamp.fromDate(
          combineDateTime(request.bookDate, request.endTime)),
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
        .createTask(ticket[0], ticket[1], ticket[2], ticket[3], true);
    final userId = context.read<AppViewModel>().app.getUser.getId;
    final id = getUuid();

    Map<String, dynamic> itemData = {
      'id': id,
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

  Future<List<RoomReservation>> fetchMyRoomReservation(String userId) async {
    List<RoomReservation> list = [];
    final roomSnapshot =
        await _roomService.getAllDocument(orderingField: "name");
    for (int i = 0; i < roomSnapshot!.docs.length; i++) {
      final reservationSnapshot = await _roomService
          .getSubDocumnetByKeyValuePair(
              roomSnapshot.docs[i].id, "reservations", ["userId"], [userId]);
      if (reservationSnapshot!.size != 0) {
        for (int j = 0; j < reservationSnapshot.docs.length; j++) {
          Timestamp bookTime = reservationSnapshot.docs[j].get("bookTime");
          Timestamp endTime = reservationSnapshot.docs[j].get("endTime");
          Timestamp dateCreate = reservationSnapshot.docs[j].get("dateCreate");
          // if (bookTime.toDate().isAfter(now)) {
          list.add(RoomReservation(
              room: roomSnapshot.docs[i].get("name"),
              id: reservationSnapshot.docs[j].id,
              purpose: reservationSnapshot.docs[j].get("purpose"),
              dateCreate: dateCreate.toDate(),
              bookTime: bookTime.toDate(),
              userId: userId,
              status: reservationSnapshot.docs[j].get("status"), 
              endTime: endTime.toDate()));
          // }
        }
      }
    }
    return list;
  }

  Future<List<ItemReservation>> fetchMyItemReservation(String userId) async {
    final snapshot =
        await _itemReservation.getDocumnetByKeyValuePair(["userId"], [userId]);
    List<ItemReservation> list = [];
    if (snapshot!.size != 0) {
      for (int i = 0; i < snapshot.docs.length; i++) {
        Timestamp startDate = snapshot.docs[i].get("startDate");
        Timestamp endDate = snapshot.docs[i].get("endDate");
        // if (endDate.toDate().isAfter(now)) {
        list.add(ItemReservation(
            id: snapshot.docs[i].id,
            objectName: snapshot.docs[i].get("objectName"),
            purpose: snapshot.docs[i].get("purpose"),
            amount: snapshot.docs[i].get("amount"),
            startDate: startDate.toDate(),
            endDate: endDate.toDate(),
            userId: snapshot.docs[i].get("userId"),
            status: snapshot.docs[i].get("status")));
        // }
      }
    }
    return list;
  }

  Future<Booking> fetchBooking(String userId) async {
    final itemRes = await fetchMyItemReservation(userId);
    final roomRes = await fetchMyRoomReservation(userId);
    final booking = Booking(roomRes: roomRes, itemRes: itemRes);
    return booking;
  }

  Future<void> cancelBooking(
      BuildContext context, String id, bool isRoom, String? detail) async {
    if (isRoom) {
      final snapshot = await _roomService
          .getDocumnetByKeyValuePair(["name"], [detail], limit: 1);
      if (snapshot!.size != 0) {
        await _roomService.deleteSubDocument(
            snapshot.docs[0].id, "reservations", id);
      }
    } else {
      final snapshot = await _itemReservation.getDocumentById(id);
      context
          .read<HelpDeskViewModel>()
          .editTask(snapshot!.get("ticketId"), true, 2);
      await _itemReservation.deleteDocument(id);
    }
    notifyListeners();
  }

  // เพิ่มรายงานการจองห้อง ในแง่ของ เลขห้อง วันเวลา
  // Future<List<RoomStatModel>> fetchRoomStatisticData(
  //     DateTime from, DateTime to) async {
  //   List<RoomStatModel> list = [];
  //   final roomSnapshot =
  //       await _roomService.getAllDocument(orderingField: "name");
  //   for (int i = 0; i < roomSnapshot!.docs.length; i++) {
  //     List<RoomReservation> res = [];
  //     final reservationSnapshot =
  //         await _roomService.getSubDocumentByDateInterval(
  //             roomSnapshot.docs[i].id,
  //             'reservations',
  //             'bookTime',
  //             startDate,
  //             endDate);
  //     if (reservationSnapshot!.size != 0) {
  //       for (int j = 0; j < reservationSnapshot.docs.length; j++) {
  //         Timestamp dateCreate = reservationSnapshot.docs[j].get("dateCreate");
  //         Timestamp bookTime = reservationSnapshot.docs[j].get("bookTime");
  //         String userId = reservationSnapshot.docs[j].get("userId");
  //         String name = "user";
  //         final nameSnapshot =
  //             await FirebaseServices("user").getDocumentById(userId);
  //         if (nameSnapshot!.exists) {
  //           name = nameSnapshot.get("name") ?? "";
  //         }

  //         res.add(RoomReservation(
  //             room: roomSnapshot.docs[i].get("name"),
  //             purpose: reservationSnapshot.docs[j].get("purpose"),
  //             dateCreate: dateCreate.toDate(),
  //             bookTime: bookTime.toDate(),
  //             userId: name,
  //             status: reservationSnapshot.docs[j].get("status")));
  //       }
  //     }

  //     list.add(RoomStatModel(
  //         roomName: roomSnapshot.docs[i].get("name"),
  //         roomCategory: roomSnapshot.docs[i].get("type"),
  //         amount: reservationSnapshot.docs.length,
  //         reservations: res));
  //   }
  //   return list;
  // }

  Future<List<RoomReservation>> fetchRoomStatisticData() async {
    List<RoomReservation> res = [];
    final roomSnapshot =
        await _roomService.getAllDocument(orderingField: "name");
    for (int i = 0; i < roomSnapshot!.docs.length; i++) {
      final reservationSnapshot = await _roomService.getAllSubDocument(
          roomSnapshot.docs[i].id, 'reservations');
      if (reservationSnapshot!.size != 0) {
        for (int j = 0; j < reservationSnapshot.docs.length; j++) {
          Timestamp dateCreate = reservationSnapshot.docs[j].get("dateCreate");
          Timestamp bookTime = reservationSnapshot.docs[j].get("bookTime");
          Timestamp endTime = reservationSnapshot.docs[j].get("endTime");
          String userId = reservationSnapshot.docs[j].get("userId");
          String name = "user";
          String email = "email";
          final nameSnapshot =
              await FirebaseServices("user").getDocumentById(userId);
          if (nameSnapshot!.exists) {
            name = nameSnapshot.get("name") ?? "";
            email = nameSnapshot.get("email") ?? "";
          } else {}

          res.add(RoomReservation(
              room: roomSnapshot.docs[i].get("name"),
              purpose: reservationSnapshot.docs[j].get("purpose"),
              dateCreate: dateCreate.toDate(),
              bookTime: bookTime.toDate(),
              endTime: endTime.toDate(),
              userId: name,
              email: email,
              status: reservationSnapshot.docs[j].get("status")));
        }
      }
    }
    return res;
  }

  Future<List<RoomStatNewModel>> fetchBookingData() async {
    List<RoomStatNewModel> roomStats = [];
    List<RoomReservation> res = await fetchRoomStatisticData();

    for (var reservation in res) {
      DateTime month =
          DateTime(reservation.bookTime.year, reservation.bookTime.month);
      bool foundMonth = false;
      for (var roomStat in roomStats) {
        if (roomStat.month == month) {
          roomStat.reservations.add(reservation);
          roomStat.amount++;
          foundMonth = true;
          break;
        }
      }
      if (!foundMonth) {
        roomStats.add(
          RoomStatNewModel(
            month: month,
            monthAndYearLabel: DateFormat('MMMM yyyy').format(month),
            amount: 1,
            reservations: [reservation],
          ),
        );
      }
    }

    roomStats.sort(((a, b) {
      return b.month.compareTo(a.month);
    }));

    return roomStats;
  }

  void setStartDate(DateTime? date) {
    if (date == null) {
      return;
    }
    startDate = date;
    // print(startDate);
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    if (date == null) {
      return;
    }
    endDate = date;
    // print(endDate);
    notifyListeners();
  }
}
