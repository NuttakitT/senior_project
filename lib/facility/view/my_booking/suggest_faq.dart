import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/create_ticket_pop_up.dart';
import 'package:senior_project/help_desk/help_desk_main/view/mobile/create_task.dart';

class SuggestFaq extends StatefulWidget {
  final bool isItemRequest; 
  final String object; 
  final DateTime bookTime;
  const SuggestFaq({super.key, required this.isItemRequest, required this.object, required this.bookTime});

  @override
  State<SuggestFaq> createState() => _SuggestFaqState();
}

class _SuggestFaqState extends State<SuggestFaq> {
  final serviceFaq = FirebaseServices("faq");
  late String selectedValue;
  bool isInIt = true;
  Map<String, dynamic> answer = {};

  void sendTicket(bool isItemRequest, String? object, DateTime bookTime) {
    bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
    bool isAdmin = context.read<AppViewModel>().app.getUser.getRole == 0;
    if (isMobileSite) {
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) {
          return CreateTask(
            isAdmin: isAdmin, 
            detail: {
              "title": "Automatically sent ticket: แจ้งปัญหาการใช้งาน${isItemRequest ? "อุปกรณ์" : "ห้อง"} $object",
              "category": isItemRequest ? "การใช้และยืมอุปกรณ์" : "การใช้งานห้องเรียน",
              "room": object,
              "bookTime": DateFormat("dd MMMM - hh:mm a")
                    .format(bookTime) 
            },
          );
        }), 
      );
    } else {
      showDialog(
        context: (context),
        builder: (context) {
          return CreateTicketPopup(
            detail: {
              "title": "Automatically sent ticket: แจ้งปัญหาการใช้งาน${isItemRequest ? "อุปกรณ์" : "ห้อง"} $object",
              "category": isItemRequest ? "การใช้และยืมอุปกรณ์" : "การใช้งานห้องเรียน",
              "room": object,
              "bookTime": DateFormat("dd MMMM - hh:mm a")
                    .format(bookTime) 
            },
          );
        }
      );
    }
  }

  Widget button(bool isMobileSite) {
    return Container(
      constraints: BoxConstraints(minWidth: isMobileSite ? double.infinity : 500),
      padding: const EdgeInsets.only(top: 16),
      child: Wrap(
        spacing: 16,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        runSpacing: 8,
        children: [
          SizedBox(
            width: 200,
            height: 40,
            child: TextButton(
              onPressed: () async {
                sendTicket(widget.isItemRequest, widget.object, widget.bookTime);
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  foregroundColor: ColorConstant.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  backgroundColor: ColorConstant.orange40,
                  textStyle: TextStyle(
                      fontSize: isMobileSite ? 16 : 20,
                      fontWeight: AppFontWeight.regular)),
              child: Text('Ask for help',
                  style: isMobileSite
                      ? AppFontStyle.whiteB16
                      : AppFontStyle.whiteSemiB20),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  foregroundColor: ColorConstant.white,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  backgroundColor: ColorConstant.orange40,
                  textStyle: TextStyle(
                      fontSize: isMobileSite ? 16 : 20,
                      fontWeight: AppFontWeight.regular)),
              child: Text('Close',
                  style: isMobileSite
                      ? AppFontStyle.whiteB16
                      : AppFontStyle.whiteSemiB20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
    return Padding(
      padding: EdgeInsets.only(top : isMobileSite ? 20 : 0),
      child: FutureBuilder(
        future: serviceFaq.getDocumnetByKeyValuePair(["category"], [widget.isItemRequest ? "การใช้และยืมอุปกรณ์" : "การใช้งานห้องเรียน"]),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data!.size == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "คำถามที่พบบ่อยในการใช้งาน",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorConstant.orange70,
                    fontWeight: AppFontWeight.bold
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20, left: 8, right: 8),
                  child: Text(
                    "ยังไม่มี FAQ ในหมวดหมู่นี้"
                  ),
                ),
                button(isMobileSite)
              ],
            );
          } else {
            if (isInIt) {
              selectedValue = "Q: ${snapshot.data!.docs.first.get("question")} \$${snapshot.data!.docs.first.id}";
            }
            for (int i = 0; i < snapshot.data!.size; i++) {
              answer.addAll({
                "${snapshot.data!.docs[i]["id"]}": snapshot.data!.docs[i]["answer"]
              });
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "คำถามที่พบบ่อยในการใช้งาน",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorConstant.orange70,
                    fontWeight: AppFontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.whiteBlack70),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    width: 500,
                    height: 50,
                    child: DropdownButton<String>(
                      underline: Container(),
                      isExpanded:  true,
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                          isInIt = false;
                        });
                      },
                      items: snapshot.data!.docs.map((e) {
                        return DropdownMenuItem<String>(
                          value: "Q: ${e.get("question")} \$${e.get("id")}",
                          child: Text("Q: ${e.get("question")}",),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (answer.isEmpty) {
                      return Container();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                      child: Text(
                        "A: ${answer[selectedValue.split(" \$")[1]]}"
                      ),
                    );
                  }
                ),
                button(isMobileSite)
              ],
            );
          }
        },
      ),
    );
  }
}