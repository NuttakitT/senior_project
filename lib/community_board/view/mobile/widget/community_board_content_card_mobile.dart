import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CommunityBoardContentCardMobile extends StatefulWidget {
  final Map<String, dynamic> info;
  const CommunityBoardContentCardMobile({super.key, required this.info});

  @override
  State<CommunityBoardContentCardMobile> createState() =>
      _CommunityBoardContentCardMobileState();
}

class _CommunityBoardContentCardMobileState
    extends State<CommunityBoardContentCardMobile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
            color: ColorConstant.whiteBlack5,
            border: Border(
              // top: BorderSide(width: 1, color: ColorConstant.whiteBlack20),
              bottom: BorderSide(width: 1, color: ColorConstant.whiteBlack20),
            )),
        padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.info["title"],
                style: const TextStyle(
                    color: ColorConstant.whiteBlack80, fontSize: 16),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Text(
                    widget.info["ownerName"],
                    style: const TextStyle(
                        color: ColorConstant.whiteBlack70, fontSize: 12),
                  ),
                ),
                Text(
                  widget.info["dateCreate"],
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack50, fontSize: 12),
                ),
                const Spacer(),
                Builder(
                  builder: (context) {
                    if (widget.info["comments"] == 0) {
                      return Container();
                    }
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.chat_rounded,
                            color: ColorConstant.whiteBlack60,
                            size: 14,
                          ),
                        ),
                        Text(
                          widget.info["comments"].toString(),
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack80, fontSize: 14),
                        ),
                      ],
                    );
                  }
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        //TODO link to detail page
      },
    );
  }
}
