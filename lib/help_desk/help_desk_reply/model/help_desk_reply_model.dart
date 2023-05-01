class HelpDeskReplyModel {
  final List<Map<String, dynamic>> _reply = [];

  void addReply(String ownerId, String text, DateTime time, bool seen, String? imageUrl) {
    _reply.add({
      "time": time,
      "text": text,
      "ownerId": ownerId,
      "seen": seen,
      "imageUrl": imageUrl
    });
  }

  List<Map<String, dynamic>> get getReply => _reply;

  void changeSeenStatus(int index, bool status) {
    _reply[index]["seen"] = status;
  }
}