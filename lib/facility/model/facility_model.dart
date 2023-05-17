class RoomModel {
  String name;
  String type;
  int capacity;
  List<RoomReservation>? reservations;

  RoomModel(
      {required this.name,
      required this.type,
      required this.capacity,
      this.reservations});
}

class RoomReservation {
  String purpose;
  DateTime dateCreate;
  DateTime bookTime;
  String userId;
  String status;

  RoomReservation(
      {required this.purpose,
      required this.dateCreate,
      required this.bookTime,
      required this.userId,
      required this.status});
}

class RoomReservationRequest {
  RoomModel room;
  String purpose;
  DateTime bookDate;
  DateTime bookTime;
  String userId;

  RoomReservationRequest(
      {required this.room,
      required this.purpose,
      required this.bookDate,
      required this.bookTime,
      required this.userId});
}

class ItemModel {
  String objectName;

  ItemModel({required this.objectName});
}

class ItemReservation {
  String objectName;
  String purpose;
  int amount;
  DateTime startDate;
  DateTime endDate;
  String status;

  ItemReservation(
      {required this.objectName,
      required this.purpose,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.status});
}

class Booking {
  List<RoomReservation> roomRes;
  List<ItemReservation> itemRes;

  Booking({required this.roomRes, required this.itemRes});
}
