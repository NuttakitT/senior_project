import 'package:flutter/material.dart';

import '../../assets/color_constant.dart';

class ApprovalDetail extends StatefulWidget {
  const ApprovalDetail({super.key});

  @override
  State<ApprovalDetail> createState() => _ApprovalDetailState();
}

class _ApprovalDetailState extends State<ApprovalDetail> {
  final List<bool> _select = <bool>[true, false];
  bool vertical = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  "Approval",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack90,
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 1,
                decoration: const BoxDecoration(color: ColorConstant.black),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 40, left: 40),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                decoration: const BoxDecoration(
                    color: ColorConstant.white,
                    // border: Border(
                    //     bottom: BorderSide(
                    //         color: ColorConstant.whiteBlack30, width: 1)),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16))),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: ColorConstant.whiteBlack70,
                        size: 24,
                      ),
                    ),
                    ToggleButtons(
                      children: <Widget>[Text("Approve"), Text("Disapprove")],
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: ColorConstant.orange60,
                      selectedColor: ColorConstant.orange40,
                      fillColor: ColorConstant.orange5,
                      color: ColorConstant.whiteBlack60,
                      constraints:
                          const BoxConstraints(minHeight: 40, minWidth: 80),
                      isSelected: _select,
                      direction: vertical ? Axis.vertical : Axis.horizontal,
                      onPressed: ((int index) {
                        setState(
                          () {
                            for (int i = 0; i < _select.length; i++) {
                              _select[i] = i == index;
                            }
                          },
                        );
                      }),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: ColorConstant.whiteBlack60,
                      size: 24,
                    ),
                    //TODO number of list
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        "1 of 95",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack70, fontSize: 16),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: ColorConstant.whiteBlack60,
                      size: 24,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration:
                    const BoxDecoration(color: ColorConstant.whiteBlack5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //TODO tittle
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Title",
                        style: TextStyle(
                            color: ColorConstant.orange70,
                            fontSize: 32,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          //TODO user
                          Padding(
                            padding: EdgeInsets.only(right: 24),
                            child: Text(
                              "Nayao",
                              style: TextStyle(
                                  color: ColorConstant.whiteBlack70,
                                  fontSize: 20),
                            ),
                          ),
                          //TODO date time
                          Text(
                            "3 Mar.",
                            style: TextStyle(
                                color: ColorConstant.whiteBlack50,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    //TODO topic tag
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: ColorConstant.white,
                            border:
                                Border.all(color: ColorConstant.whiteBlack30),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Text(
                          "topic",
                          style: TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 18),
                        ),
                      ),
                    ),
                    //TODO detail
                    const Text(
                      "ปฏิทินการลงทะเบียน",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack90, fontSize: 20),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
