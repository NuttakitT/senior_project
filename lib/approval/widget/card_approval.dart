import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CardApproval extends StatefulWidget {
  const CardApproval({super.key});

  @override
  State<CardApproval> createState() => _CardApprovalState();
}

class _CardApprovalState extends State<CardApproval> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 180,
              child: Text(
                "Name",
                style: TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      width: 50,
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      decoration: BoxDecoration(
                          color: ColorConstant.white,
                          border: Border.all(color: ColorConstant.whiteBlack30),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: const Text(
                        "Topic",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack70, fontSize: 12),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    decoration: BoxDecoration(
                        color: ColorConstant.white,
                        border: Border.all(color: ColorConstant.whiteBlack30),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: const Text(
                      "Topic",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 612,
              child: RichText(
                  text: const TextSpan(children: [
                //TODO tittle
                TextSpan(
                    text: "Tittle ",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                TextSpan(
                    text: "- ",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack60, fontSize: 16)),
                //TODO description
                TextSpan(
                    text: "description",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack60, fontSize: 16))
              ])),
            ),
          ),
          Spacer(),
          const SizedBox(
              width: 70,
              child: Text(
                "Datetime",
                style:
                    TextStyle(color: ColorConstant.whiteBlack60, fontSize: 16),
              ))
        ],
      ),
    );
  }
}
