import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/teacher_contact/view/widget/add_contact_popup.dart';
import 'package:senior_project/teacher_contact/view_model/teacher_contact_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../assets/color_constant.dart';

class TeacherContactDesktopCard extends StatelessWidget {
  const TeacherContactDesktopCard({super.key, required this.cardDetail});
  final Map<String, dynamic> cardDetail;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstant.orange50, width: 1),
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
                    cardDetail['imageUrl'],
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
                  style: AppFontStyle.wb70R16,
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
          Expanded(
            child: Stack(children: [
              Column(
                children: [
                  TeachContactDesktopDetailCell(
                    title: "Mail",
                    detail: cardDetail['email'],
                  ),
                  TeachContactDesktopDetailCell(
                    title: "Phone",
                    detail: cardDetail['phone'],
                  ),
                  TeachContactDesktopDetailCell(
                    title: "Office Hours",
                    detail: cardDetail['officeHours'],
                  ),
                  TeachContactDesktopDetailCell(
                    title: "Subject",
                    detail: cardDetail['subject'],
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundColor: ColorConstant.facebookColor,
                        child: IconButton(
                          onPressed: () async {
                            Uri uri = Uri.parse(cardDetail['facebookLink']);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              throw 'Link broken';
                            }
                          },
                          icon: const Icon(Icons.facebook),
                          color: ColorConstant.white,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstant.black,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () async {
                            final Uri params = Uri(
                              scheme: 'mailto',
                              path: cardDetail['email'],
                            );
                            Uri uri = Uri.parse(params.toString());
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              throw 'Could not launch $uri';
                            }
                          },
                          icon: const Icon(Icons.mail),
                          color: ColorConstant.black,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstant.green40,
                          width: 1.0,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () async {
                            final phoneString = "tel:${cardDetail['phone']}";
                            Uri uri = Uri.parse(phoneString);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri);
                            } else {
                              throw 'Phone number is invalid';
                            }
                          },
                          icon: const Icon(Icons.phone),
                          color: ColorConstant.green40,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}

class TeachContactDesktopDetailCell extends StatelessWidget {
  const TeachContactDesktopDetailCell(
      {Key? key, required this.title, required this.detail})
      : super(key: key);

  final String title;
  final dynamic detail;

  @override
  Widget build(BuildContext context) {
    final detailString = detail.toString();
    if (detailString == "null") {
      return Container();
    }

    return ChangeNotifierProvider(
      create: (_) => TeacherContactViewModel(),
      child: Consumer<TeacherContactViewModel>(
          builder: (context, viewModel, child) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3,
                    child: DefaultTextStyle(
                        style: AppFontStyle.wb50R16, child: Text(title))),
                Expanded(
                  flex: 7,
                  child: DefaultTextStyle(
                      style: AppFontStyle.wb80R16, child: Text(detailString)),
                ),
              ],
            ),
            const SizedBox(height: 8.0)
          ],
        );
      }),
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
            child: Text("Teacher Contact"),
          ),
          const Spacer(),
          if (isAdmin)
            ChangeNotifierProvider(
              create: (_) => TeacherContactViewModel(),
              child: Consumer<TeacherContactViewModel>(
                  builder: (context, viewModel, child) {
                return SizedBox(
                  width: 178,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const AddContactPopup();
                          });
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
                );
              }),
            )
        ],
      ),
    );
  }
}
