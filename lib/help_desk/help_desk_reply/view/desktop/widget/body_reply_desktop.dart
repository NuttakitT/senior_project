import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/desktop/widget/chat_input_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/desktop/widget/description_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/message.dart';

class BodyReplyDesktop extends StatefulWidget {
  const BodyReplyDesktop({super.key});

  @override
  State<BodyReplyDesktop> createState() => _BodyReplyDesktopState();
}

class _BodyReplyDesktopState extends State<BodyReplyDesktop> {
  List<Map<String, dynamic>> data = [
    {
      "text": "Hi people",
      "isSender": true
    },
    {
      "text": "Okay, How r u?",
      "isSender": false
    },
    {
      "text": "Fine",
      "isSender": true
    },
    {
      "text": "asddsssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
      "isSender": false
    }
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    int? role = context.watch<AppViewModel>().app.getUser.getRole; 

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: ColorConstant.whiteBlack15,
                                width: 1,
                                strokeAlign: StrokeAlign.inside))),
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorConstant.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(1, -2),
                                  color: ColorConstant.black.withOpacity(0.05),
                                  blurRadius: 4)
                            ],
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        height: 80,
                        //TODO name of task / Pull from back-end
                        child: const Text(
                          "Lorem Ipsum",
                          style: TextStyle(
                              color: ColorConstant.whiteBlack80,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 300),
                    height: 680 + (screenHeight - 960),
                    decoration: const BoxDecoration(color: ColorConstant.white),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) => Message(
                          isSender:  data[index]["isSender"],
                          text: data[index]["text"],
                        ),
                      ),
                    ),
                  ),
                  const ChatInputDesktop(),
                ],
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: DescriptionDesktop(
              isAdmin: role == 0 ? true : false,
            )
          )
        ],
      ),
    );
  }
}