class HelpDeskReplyModel {
  final List<Map<String, dynamic>> _reply = [];

  void addReply(String ownerId, String text, DateTime time, bool seen) {
    _reply.add({
      "time": DateTime,
      "text": text,
      "ownerId": ownerId,
      "seen": seen
    });
  }

  List<Map<String, dynamic>> get getReply => _reply;

  void changeSeenStatus(int index, bool status) {
    _reply[index]["seen"] = status;
  }
}