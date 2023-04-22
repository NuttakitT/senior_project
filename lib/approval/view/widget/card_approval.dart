import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CardApproval extends StatefulWidget {
  final Map<String, dynamic> info;
  const CardApproval({super.key, required this.info});

  @override
  State<CardApproval> createState() => _CardApprovalState();
}

class _CardApprovalState extends State<CardApproval> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 1128,
        height: 58,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: ColorConstant.white,
            border: Border(
                top: BorderSide(color: ColorConstant.whiteBlack30),
                bottom: BorderSide(color: ColorConstant.whiteBlack30))),
        child: Row(
          children: [
            //TODO name
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 180,
                child: Text(
                  widget.info["name"],
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack90,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            //TODO topic
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 186,
                child: Row(
                  children: [
                    //TODO loop topic
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        width: 50,
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                        decoration: BoxDecoration(
                            color: ColorConstant.white,
                            border:
                                Border.all(color: ColorConstant.whiteBlack30),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          widget.info["topic"],
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 12),
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 50,
                    //   padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    //   decoration: BoxDecoration(
                    //       color: ColorConstant.white,
                    //       border: Border.all(color: ColorConstant.whiteBlack30),
                    //       borderRadius:
                    //           const BorderRadius.all(Radius.circular(8))),
                    //   child: const Text(
                    //     "Topic",
                    //     style: TextStyle(
                    //         color: ColorConstant.whiteBlack70, fontSize: 12),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 612,
                child: RichText(
                    text: TextSpan(children: [
                  //TODO tittle
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
                  //TODO detail of post
                  TextSpan(
                      text: widget.info["detail"],
                      style: const TextStyle(
                          color: ColorConstant.whiteBlack60, fontSize: 16))
                ])),
              ),
            ),
            const Spacer(),
            SizedBox(
                width: 70,
                child: Text(
                  widget.info["dateCreate"],
                  style: const TextStyle(
                      color: ColorConstant.whiteBlack60, fontSize: 16),
                ))
          ],
        ),
      ),
      onTap: () {
        //TODO link to detailpost
      },
    );
  }
}
