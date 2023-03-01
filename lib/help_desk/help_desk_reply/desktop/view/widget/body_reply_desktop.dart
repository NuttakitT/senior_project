import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_reply_demo.dart';
import 'package:senior_project/help_desk/help_desk_reply/desktop/view/widget/chat_input_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/desktop/view/widget/description_desktop.dart';

class BodyReplyDesktop extends StatelessWidget {
  const BodyReplyDesktop({super.key});

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
                        itemCount: demoMessage.length,
                        itemBuilder: (context, index) => Message(
                          message: demoMessage[index],
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

class Message extends StatelessWidget {
  const Message({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageChat message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment:
            message.isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isSender) ...[
            //TODO Pull image profile sender
            const Icon(
              Icons.face_rounded,
              color: ColorConstant.red40,
            )
          ],
          const SizedBox(width: 8),
          TextMessage(
            messages: message,
          ),
          //status
          if (message.isSender) const MessageStatusDot()
        ],
      ),
    );
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final MessageChat messages;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color:
                ColorConstant.orange30.withOpacity(messages.isSender ? 1 : 0.4),
            borderRadius: BorderRadius.circular(24)),
        child: Text(
          messages.text,
          style:
              const TextStyle(color: ColorConstant.whiteBlack80, fontSize: 16),
        ));
  }
}

class MessageStatusDot extends StatelessWidget {
  const MessageStatusDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 12,
      width: 12,
      decoration: const BoxDecoration(
          color: ColorConstant.green40, shape: BoxShape.circle),
      child: const Icon(
        Icons.done_rounded,
        size: 8,
        color: ColorConstant.white,
      ),
    );
  }
}
