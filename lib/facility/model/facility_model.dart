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
  String? id;
  String purpose;
  DateTime dateCreate;
  DateTime bookTime;
  String userId;
  String status;
  String? room; // for watch bookings
  String? email;

  RoomReservation(
      {this.id,
      required this.purpose,
      required this.dateCreate,
      required this.bookTime,
      required this.userId,
      required this.status,
      this.room,
      this.email});
}

class RoomStatModel {
  String roomName;
  String roomCategory;
  int amount;
  List<RoomReservation> reservations;

  RoomStatModel(
      {required this.roomName,
      required this.roomCategory,
      required this.amount,
      required this.reservations});
}

class RoomStatNewModel {
  DateTime month;
  String monthAndYearLabel;
  int amount;
  List<RoomReservation> reservations;

  RoomStatNewModel(
      {required this.month,
      required this.monthAndYearLabel,
      required this.amount,
      required this.reservations});
}

class Schedule {
  String? id;
  String roomName;
  int dayOfWeek;
  DateTime startTime;
  DateTime endTime;

  Schedule(
      {this.id,
      required this.roomName,
      required this.dayOfWeek,
      required this.startTime,
      required this.endTime});
}

class RoomReservationRequest {
  String purpose;
  DateTime bookDate;
  DateTime bookTime;
  DateTime endTime;
  String userId;

  RoomReservationRequest(
      {required this.purpose,
      required this.bookDate,
      required this.bookTime,
      required this.endTime,
      required this.userId});
}

class ItemModel {
  String objectName;

  ItemModel({required this.objectName});
}

class ItemReservation {
  String? id;
  String objectName;
  String purpose;
  int amount;
  DateTime startDate;
  DateTime endDate;
  String userId;
  String status;
  String? ticketId;

  ItemReservation(
      {this.id,
      required this.objectName,
      required this.purpose,
      required this.amount,
      required this.startDate,
      required this.endDate,
      required this.userId,
      required this.status,
      this.ticketId});
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
