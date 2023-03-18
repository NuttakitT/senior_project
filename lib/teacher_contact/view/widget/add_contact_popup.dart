import 'dart:html' as html;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/teacher_contact/model/teacher_contact_model.dart';
import 'package:senior_project/teacher_contact/view_model/teacher_contact_view_model.dart';

class AddContactPopup extends StatefulWidget {
  const AddContactPopup({super.key});

  @override
  State<AddContactPopup> createState() => _AddContactPopupState();
}

class _AddContactPopupState extends State<AddContactPopup> {
  static List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  TimeOfDay startTime = TimeOfDay(hour: 8, minute: 30);
  TimeOfDay endTime = TimeOfDay(hour: 17, minute: 30);

  String firstName = "";
  bool isFirstNameEmpty = false;
  String lastName = "";
  bool isLastNameEmpty = false;
  String firstNameThai = "";
  bool isFirstNameThaiEmpty = false;
  String lastNameThai = "";
  bool isLastNameThaiEmpty = false;
  String email = "";
  bool isEmailEmpty = false;
  String phoneNumber = "";
  bool isPhoneNumberEmpty = false;
  String startHours = "";
  String endHours = "";
  String officeHourDay = daysOfWeek.first;
  String facebookLink = "";
  bool isFacebookLinkEmpty = false;
  List<String> selectedSubjects = [];
  bool isSubjectEmpty = false;
  String profileImage = "";

  File? imageFile;
  String? imageUrl;
  final picker = ImagePicker();

  bool get textFieldAllFilled =>
      !isFirstNameEmpty &&
      !isLastNameEmpty &&
      !isFirstNameThaiEmpty &&
      !isLastNameThaiEmpty &&
      !isEmailEmpty &&
      !isPhoneNumberEmpty &&
      !isFacebookLinkEmpty &&
      !isSubjectEmpty;

  Color setColorOfTextField(bool emptyFlag) {
    if (!emptyFlag) {
      return ColorConstant.whiteBlack40;
    }
    return ColorConstant.red40;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final startTimeHour = startTime.hour.toString().padLeft(2, '0');
    final startTimeMinute = startTime.minute.toString().padLeft(2, '0');

    final endTimeHour = endTime.hour.toString().padLeft(2, '0');
    final endTimeMinute = endTime.minute.toString().padLeft(2, '0');

    return AlertDialog(
      backgroundColor: ColorConstant.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 1000,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    DefaultTextStyle(
                        style: AppFontStyle.orange70Md28,
                        child: Text(Consts.addContactTitle)),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                DefaultTextStyle(
                    style: AppFontStyle.wb60L18,
                    child: Text(Consts.addContactDetail)),
                // [1] First Name and Last Name
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.firstNameLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: setColorOfTextField(
                                          isFirstNameEmpty)),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "First Name eg. Nick"),
                                    onChanged: (value) {
                                      firstName = value;
                                    },
                                    onTap: () {
                                      setState(() {
                                        isFirstNameEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.lastNameLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color:
                                          setColorOfTextField(isLastNameEmpty)),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    onChanged: (value) {
                                      lastName = value;
                                    },
                                    onTap: () {
                                      setState(() {
                                        isLastNameEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                // End
                // [1.5] THAI First Name and Last Name
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.firstNameThaiLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: setColorOfTextField(
                                          isFirstNameThaiEmpty)),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    onChanged: (value) {
                                      firstNameThai = value;
                                    },
                                    onTap: () {
                                      setState(() {
                                        isFirstNameThaiEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.lastNameThaiLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: setColorOfTextField(
                                          isLastNameThaiEmpty)),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    onChanged: (value) {
                                      lastNameThai = value;
                                    },
                                    onTap: () {
                                      setState(() {
                                        isLastNameThaiEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                // End
                // [2] Email and Phone Number
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.emailLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: setColorOfTextField(isEmailEmpty)),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    onTap: () {
                                      setState(() {
                                        isEmailEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.phoneNumberLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: setColorOfTextField(
                                          isPhoneNumberEmpty)),
                                ),
                                child: Center(
                                  child: TextField(
                                    decoration: const InputDecoration.collapsed(
                                        hintText: ""),
                                    onChanged: (value) {
                                      phoneNumber = value;
                                    },
                                    onTap: () {
                                      setState(() {
                                        isPhoneNumberEmpty = false;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                // End
                // [2.5] Office Hours
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.officeHoursLabel)),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 158,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: setColorOfTextField(
                                                false)), // False is not empty
                                      ),
                                      child: GestureDetector(
                                        child: Text(
                                          '$startTimeHour:$startTimeMinute',
                                          style: AppFontStyle.wb80R16,
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: startTime,
                                          );

                                          if (newTime == null) return;

                                          setState(() {
                                            startTime = newTime;
                                          });
                                        },
                                      ),
                                    ),
                                    const Spacer(),
                                    DefaultTextStyle(
                                        style: AppFontStyle.wb60R14,
                                        child: Text(Consts.to)),
                                    const Spacer(),
                                    Container(
                                      width: 158,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: setColorOfTextField(
                                                false)), // False is not empty
                                      ),
                                      child: GestureDetector(
                                        child: Text(
                                          '$endTimeHour:$endTimeMinute',
                                          style: AppFontStyle.wb80R16,
                                          textAlign: TextAlign.center,
                                        ),
                                        onTap: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                            context: context,
                                            initialTime: endTime,
                                          );

                                          if (newTime == null) return;

                                          setState(() {
                                            endTime = newTime;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.officeDayLabel)),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 478,
                                child: Container(
                                  height: 40,
                                  width: 478,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: setColorOfTextField(false)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: officeHourDay,
                                      style: AppFontStyle.wb60R16,
                                      items: daysOfWeek
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(value),
                                            ));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          officeHourDay = value!;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                // End
                // [3] FacebookLink
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.facebookLinkLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                      color: setColorOfTextField(
                                          isFacebookLinkEmpty)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: TextField(
                                      decoration:
                                          const InputDecoration.collapsed(
                                              hintText: ""),
                                      onChanged: (value) {
                                        facebookLink = value;
                                      },
                                      onTap: () {
                                        setState(() {
                                          isFacebookLinkEmpty = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.subjectLabel)),
                              const SizedBox(height: 8),
                              Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: setColorOfTextField(
                                            isSubjectEmpty)),
                                  ),
                                  child: FutureBuilder(
                                      future: context
                                          .read<TeacherContactViewModel>()
                                          .getSubjects(),
                                      builder: (context, snapshot) {
                                        List<Subject> subjects =
                                            Subject.subjectsFromJson(
                                                snapshot.data);
                                        final items = subjects
                                            .map((subject) => MultiSelectItem<
                                                    Subject>(subject,
                                                "${subject.id} ${subject.name}"))
                                            .toList();
                                        return MultiSelectDialogField(
                                          initialValue: const [],
                                          items: items,
                                          onConfirm: (selectedList) {
                                            selectedSubjects = context
                                                .read<TeacherContactViewModel>()
                                                .getSubjectStrings(
                                                    selectedList);
                                          },
                                        );
                                      })),
                            ]),
                      ),
                    ),
                  ],
                ),
                // End
                // [5] Image
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DefaultTextStyle(
                                  style: AppFontStyle.wb80R20,
                                  child: Text(Consts.uploadImageLabel)),
                              const SizedBox(height: 8),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    final pickedFile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (pickedFile != null) {
                                      setState(() {
                                        //  imageUrl = _uploadImage(File(pickedFile.path));
                                        // imageUrl = context
                                        //     .read<TeacherContactViewModel>()
                                        //     .getImageUrl(pickedFile.path);
                                      });
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorConstant.orange40),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: const BorderSide(
                                                  color: ColorConstant
                                                      .orange40)))),
                                  child: Text(
                                    Consts.upload,
                                    style: AppFontStyle.whiteB16,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
                // End
                const SizedBox(height: 8),
                // [] Button Bar
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: const BorderSide(
                                            color: ColorConstant.orange40)))),
                            child: Text(
                              Consts.cancel,
                              style: AppFontStyle.orange40B16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextButton(
                          onPressed: () async {
                            if (firstName.isEmpty ||
                                context
                                        .read<TeacherContactViewModel>()
                                        .validateNameField(firstName) ==
                                    false) {
                              setState(() {
                                isFirstNameEmpty = true;
                              });
                            }
                            if (lastName.isEmpty ||
                                context
                                        .read<TeacherContactViewModel>()
                                        .validateNameField(lastName) ==
                                    false) {
                              setState(() {
                                isLastNameEmpty = true;
                              });
                            }
                            if (firstNameThai.isEmpty ||
                                context
                                        .read<TeacherContactViewModel>()
                                        .validateNameField(firstNameThai) ==
                                    false) {
                              setState(() {
                                isFirstNameThaiEmpty = true;
                              });
                            }
                            if (lastNameThai.isEmpty ||
                                context
                                        .read<TeacherContactViewModel>()
                                        .validateNameField(lastNameThai) ==
                                    false) {
                              setState(() {
                                isLastNameThaiEmpty = true;
                              });
                            }
                            if (email.isEmpty ||
                                context
                                        .read<TeacherContactViewModel>()
                                        .validateEmailField(email) ==
                                    false) {
                              setState(() {
                                isEmailEmpty = true;
                              });
                            }
                            if (phoneNumber.isEmpty ||
                                context
                                        .read<TeacherContactViewModel>()
                                        .validatePhoneNumber(phoneNumber) ==
                                    false) {
                              setState(() {
                                isPhoneNumberEmpty = true;
                              });
                            }
                            if (facebookLink.isEmpty) {
                              setState(() {
                                isFacebookLinkEmpty = true;
                              });
                            }
                            if (selectedSubjects.isEmpty) {
                              setState(() {
                                isFacebookLinkEmpty = true;
                              });
                            }
                            if (textFieldAllFilled) {
                              final officeHours =
                                  '$officeHourDay $startTimeHour:$startTimeMinute - $endTimeHour:$endTimeMinute';
                              final request = AddTeacherContactRequest(
                                imageUrl: "https://picsum.photos/200/300",
                                firstName: firstName,
                                lastName: lastName,
                                thaiName: firstNameThai,
                                thaiLastName: lastNameThai,
                                email: email,
                                phone: phoneNumber,
                                officeHours: officeHours,
                                facebookLink: facebookLink,
                                subjectId: selectedSubjects,
                              );
                              await context
                                  .read<TeacherContactViewModel>()
                                  .createNewContact(request);

                              Navigator.pop(context);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstant.orange40),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                          color: ColorConstant.orange40)))),
                          child: Text(
                            Consts.confirm,
                            style: AppFontStyle.whiteB16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // [] End
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Consts {
  static String addContactTitle = "Add Contact";
  static String addContactDetail = "Fill in more information of teacher.";
  static String firstNameLabel = "First Name";
  static String lastNameLabel = "Last Name";
  static String firstNameThaiLabel = "Thai First Name";
  static String lastNameThaiLabel = "Thai Last Name";
  static String emailLabel = "E-mail";
  static String phoneNumberLabel = "Phone number";
  static String officeHoursLabel = "Office Hours";
  static String officeDayLabel = "Office Day";
  static String facebookLinkLabel = "Facebook link";
  static String subjectLabel = "Subject";
  static String uploadImageLabel = "Profile Image";

  static String cancel = "Cancel";
  static String confirm = "Confirm";
  static String to = "to";
  static String upload = "Upload";
}
