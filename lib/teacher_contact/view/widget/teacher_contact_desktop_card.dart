import 'package:flutter/material.dart';
import 'package:senior_project/assets/font_style.dart';

import '../../../assets/color_constant.dart';

class TeacherContactDesktopCard extends StatelessWidget {
  const TeacherContactDesktopCard({super.key, required this.cardDetail});
  final Map<String, dynamic> cardDetail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF9800), width: 1),
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // left column
            SizedBox(
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      cardDetail['image'],
                      width: 140.0,
                      height: 140.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  DefaultTextStyle(
                    style: AppFontStyle.wb80Md24,
                    child: Text(
                      cardDetail['name'] + " " + cardDetail['surname'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DefaultTextStyle(
                    style: AppFontStyle.wb80Md24,
                    child: Text(
                      cardDetail['thaiName'] + ' ' + cardDetail['thaiSurname'],
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
            // right column
            SizedBox(
              width: 450, // need adjust
              child: Column(
                children: [
                  TeachContactDesktopDetailCell(
                    title: "Mail",
                    detail: cardDetail['email'],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TeachContactDesktopDetailCell extends StatelessWidget {
  const TeachContactDesktopDetailCell(
      {Key? key, required this.title, required this.detail})
      : super(key: key);

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return Container();
    }
    return Row(
      children: [
        Expanded(
            flex: 3,
            child: DefaultTextStyle(
                style: AppFontStyle.wb50R16, child: Text(title))),
        Expanded(
            flex: 7,
            child: DefaultTextStyle(
                style: AppFontStyle.wb80R16, child: Text(detail!))),
        const SizedBox(
          height: 8.0,
        )
      ],
    );
  }
}

class TeacherContactDesktopHeader extends StatelessWidget {
  const TeacherContactDesktopHeader({super.key, required this.isAdmin});
  final bool isAdmin;

  static TextStyle createTaskButtonStyle = AppFontStyle.whiteSemiB16;
  static TextStyle titleTextStyle = AppFontStyle.wb80Md32;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 24, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DefaultTextStyle(
            style: AppFontStyle.wb80Md32,
            child: Text("My Profile"),
          ),
          const Spacer(),
          if (isAdmin)
            SizedBox(
              width: 178,
              height: 40,
              child: TextButton(
                onPressed: () {
                  // TODO edit profile lofic
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstant.orange40),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Add Contact",
                      style: AppFontStyle.whiteSemiB16,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
