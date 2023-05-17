// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';
import 'package:uuid/uuid.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController controller = TextEditingController();
  XFile? pickedFile;
  Uint8List? imageFile;
  bool hasImage = false;

  Future<void> sendMessage() async {
    String userId = context.read<AppViewModel>().app.getUser.getId;
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await context.read<ReplyChannelViewModel>().getImageUrl(imageFile, "${const Uuid().v1()}_${pickedFile!.name}", context.read<ReplyChannelViewModel>().getTaskData["docId"]);
    }
    if (imageFile != null || controller.text.isNotEmpty) {
      await context.read<ReplyChannelViewModel>().createMessage(
        context.read<ReplyChannelViewModel>().getTaskData["docId"], 
        {
          "ownerId": userId,
          "message": controller.text,
          "time": DateTime.now(),
          "seen": false,
          "imageUrl": imageUrl
        }
      );
      imageFile = null;
      pickedFile =  null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 70),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorConstant.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: ColorConstant.black.withOpacity(0.08),
                blurRadius: 100,
              ),
            ],
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16))),
        child: Row(
          children: [
            Builder(
              builder: (context) {
                if (hasImage) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Container(
                            height: 40,
                            width: 70,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: ColorConstant.whiteBlack40),
                              color: Colors.white
                            ),
                            alignment: Alignment.centerLeft,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                pickedFile!.name.toString(),
                                style: const TextStyle(
                                  color: ColorConstant.whiteBlack50, fontSize: 14
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            imageFile = null;
                            setState(() {
                              hasImage = false;
                            });
                          }, 
                          icon: const Icon(
                            Icons.delete_rounded
                          )
                        )
                      ],
                    ),
                  );
                }
                return InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(360)),
                    child: const Icon(
                      Icons.add,
                      color: ColorConstant.blue40,
                    ),
                  ),
                  onTap: () async {
                    pickedFile = await ImagePicker()
                      .pickImage(
                          source: ImageSource.gallery);
                    if (pickedFile != null) {
                      imageFile = await pickedFile!.readAsBytes();
                      setState(() {
                        hasImage = true;
                      });
                    }
                  },
                );
              }
            ),
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: ColorConstant.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorConstant.whiteBlack40)),
              child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  scrollPadding: const EdgeInsets.all(0),
                  decoration: const InputDecoration.collapsed(
                      hintText: "Type message...", border: InputBorder.none),
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack50, fontSize: 14),
                  onSubmitted: (value) async {
                    await sendMessage();
                  },
                ),
              ),
            )),
            // InkWell(
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 8.0),
            //     child: Icon(
            //       Icons.sentiment_satisfied_alt_rounded,
            //       color: ColorConstant.blue40,
            //     ),
            //   ),
            //   onTap: () {
            //   },
            // ),
            InkWell(
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(
                  Icons.send_rounded,
                  color: ColorConstant.blue40,
                ),
              ),
              onTap: () async {
                await sendMessage();
              },
            )
          ],
        ),
      ),
    );
  }
}
