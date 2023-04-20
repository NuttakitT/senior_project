import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class ContentCardTemplate extends StatefulWidget {
  final Map<String, dynamic> info;
  const ContentCardTemplate({super.key, required this.info});

  @override
  State<ContentCardTemplate> createState() => _ContentCardTemplateState();
}

class _ContentCardTemplateState extends State<ContentCardTemplate> {
  List<Widget> getTopic(List<dynamic> topic) {
    List<Widget> topicWidget = [
      const Padding(
        padding: EdgeInsets.only(right: 24),
        child: Text(
          "Topic : ",
          style: TextStyle(
              color: ColorConstant.whiteBlack50, fontSize: 20),
        ),
      ),
    ];
    for (int i = 0; i < topic.length; i++) {
      topicWidget.add(
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Text(
            topic[i].toString(),
            style: const TextStyle(
                color: ColorConstant.whiteBlack70, fontSize: 18),
          ),
        ),
      );
    }
    return topicWidget;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
            color: ColorConstant.whiteBlack5,
            border: Border(
                left: BorderSide(width: 1, color: ColorConstant.whiteBlack40),
                bottom: BorderSide(width: 1, color: ColorConstant.whiteBlack40),
                right:
                    BorderSide(width: 1, color: ColorConstant.whiteBlack40))),
        padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.info["title"],
                style: const TextStyle(
                    color: ColorConstant.whiteBlack80, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: getTopic(widget.info["topic"])
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(
                    widget.info["ownerName"],
                    style: const TextStyle(
                        color: ColorConstant.whiteBlack70, fontSize: 18),
                  ),
                ),
                Text(
                  widget.info["dateCreate"],
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack50, fontSize: 16),
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
                          ),
                        ),
                        Text(
                          widget.info["comments"].toString(),
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack80, fontSize: 18),
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
