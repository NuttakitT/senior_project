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
  String? room; // for watch bookings

  RoomReservation(
      {required this.purpose,
      required this.dateCreate,
      required this.bookTime,
      required this.userId,
      required this.status,
      this.room});
}

class RoomReservationRequest {
  String purpose;
  DateTime bookDate;
  DateTime bookTime;
  String userId;

  RoomReservationRequest(
      {required this.purpose,
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
  String userId;
  String status;

  ItemReservation(
      {required this.objectName,
      required this.purpose,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.userId,
      required this.status});
}

class Booking {
  List<RoomReservation> roomRes;
  List<ItemReservation> itemRes;

  Booking({required this.roomRes, required this.itemRes});
}

class BookingCard {
  String title;
  String detail;
  String createTime;
  String requestTime;
  String status;

  BookingCard(
      {required this.title,
      required this.detail,
      required this.createTime,
      required this.requestTime,
      required this.status});
}
