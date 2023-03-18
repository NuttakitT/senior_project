import 'package:uuid/uuid.dart';

class TeacherContactModel {
  final String? id;
  final String imageUrl;
  final String name;
  final String thaiName;
  final String email;
  final String phone;
  final String officeHours;
  final String facebookLink;
  final List<String> subjectId;

  TeacherContactModel(
      {this.id,
      required this.imageUrl,
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

class AddTeacherContactRequest {
  String imageUrl;
  String firstName;
  String lastName;
  String thaiName;
  String thaiLastName;
  String email;
  String phone;
  final String officeHours;
  final String facebookLink;
  final List<String> subjectId;

  AddTeacherContactRequest(
      {required this.imageUrl,
      required this.firstName,
      required this.lastName,
      required this.thaiName,
      required this.thaiLastName,
      required this.email,
      required this.phone,
      required this.officeHours,
      required this.facebookLink,
      required this.subjectId});
}

class Subject {
  String id;
  String name;

  Subject({required this.id, required this.name});

  static List<Subject> subjectsFromJson(List<Map<String, dynamic>?>? json) {
    if (json == null) {
      return [];
    }
    return json.map((subject) {
      return Subject(
        id: subject!['subjectId'],
        name: subject['name'],
      );
    }).toList();
  }
}
