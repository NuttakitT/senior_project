class ApprovalModel {
  List<Map<String, dynamic>> allField = [];

  set setPostDetail(Map<String, dynamic> alldetail) {
    allField.add(alldetail);
  }

  get getPostDeatail {
    return allField;
  }

  void clearModel() {
    allField = [];
  }
}
