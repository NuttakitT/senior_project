// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:senior_project/approval/view/widget/approval_detail.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:intl/intl.dart';

class CardApproval extends StatefulWidget {
  final Map<String, dynamic> info;
  final int checknumcard;
  const CardApproval(
      {super.key, required this.info, required this.checknumcard});

  @override
  State<CardApproval> createState() => _CardApprovalState();
}

class _CardApprovalState extends State<CardApproval> {
  List<Widget> generateCardTopics(List<dynamic> listPost) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      card.add(
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: BoxDecoration(
                color: ColorConstant.white,
                border: Border.all(color: ColorConstant.whiteBlack30),
                borderRadius: const BorderRadius.all(Radius.circular(8))),
            child: Text(
              listPost[i].toString(),
              style: const TextStyle(
                  color: ColorConstant.whiteBlack70, fontSize: 12),
            ),
          ),
        ),
      );
    }
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: 58,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: ColorConstant.white,
            border: Border(
                top: BorderSide(color: ColorConstant.whiteBlack30),
                bottom: BorderSide(color: ColorConstant.whiteBlack30))),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                  width: 180,
                  child: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: widget.info["ownerName"],
                              style: const TextStyle(
                                  color: ColorConstant.whiteBlack90,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600))
                        ],
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 186,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:
                      Row(children: generateCardTopics(widget.info["topics"])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: widget.info["title"],
                    style: const TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const TextSpan(
                    text: "- ",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack60, fontSize: 16)),
                TextSpan(
                    text: widget.info["detail"],
                    style: const TextStyle(
                        color: ColorConstant.whiteBlack60, fontSize: 16))
              ])),
            ),
            const Spacer(),
            Text(
              DateFormat('dd MMM').format(widget.info["dateCreate"]),
              style: const TextStyle(
                  color: ColorConstant.whiteBlack60, fontSize: 16),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return ApprovalDetail(checknumcard: widget.checknumcard);
        })));
      },
    );
  }
}
