class TeacherContactModel {
  final String id;
  final String imageUrl;
  final String gender;
  final String name;
  final String thaiName;
  final String email;
  final String phone;
  final String officeHours;
  final String facebookLink;
  final List<String> subjectId;

  TeacherContactModel(
      {required this.id,
      required this.imageUrl,
      required this.gender,
      required this.name,
      required this.thaiName,
      required this.email,
      required this.phone,
      required this.officeHours,
      required this.facebookLink,
      required this.subjectId});

  Map<String, dynamic> toMap() {
    var nameOnly = name.split("_")[0];
    var surnameOnly = name.split("_")[1];

    var thaiNameOnly = thaiName.split("_")[0];
    var thaiSurnameOnly = thaiName.split("_")[1];

    return {
      'id': id,
      'imageUrl': imageUrl,
      'gender': gender,
      'name': nameOnly,
      'surname': surnameOnly,
      'thaiName': thaiNameOnly,
      'thaiSurname': thaiSurnameOnly,
      'email': email,
      'phone': phone,
      'officeHours': officeHours,
      'facebookLink': facebookLink,
      'subjectId': subjectId
    };
  }
}
