import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:provider/provider.dart';

class ContentCardTemplate extends StatefulWidget {
  final Map<String, dynamic> info;
  const ContentCardTemplate({super.key, required this.info});

  @override
  State<ContentCardTemplate> createState() => _ContentCardTemplateState();
}

class _ContentCardTemplateState extends State<ContentCardTemplate> {
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
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Text(
                      "Topic : ",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack50, fontSize: 20),
                    ),
                  ),
                  //TODO loop topic
                  Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Text(
                      widget.info["topic"],
                      style: const TextStyle(
                          color: ColorConstant.whiteBlack70, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                //TODO user
                const Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Text(
                    "Nayao",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack70, fontSize: 18),
                  ),
                ),
                //TODO datetime
                const Text(
                  "25 Feb.",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack50, fontSize: 16),
                ),
                const Spacer(),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.chat_rounded,
                        color: ColorConstant.whiteBlack60,
                      ),
                    ),
                    //TODO number comment
                    Text(
                      "14",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack80, fontSize: 18),
                    ),
                  ],
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
