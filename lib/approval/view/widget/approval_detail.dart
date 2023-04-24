// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import '../../../assets/color_constant.dart';
import '../../model/approval_model.dart';
import '../page/template_approval.dart';
import 'package:intl/intl.dart';

class ApprovalDetail extends StatefulWidget {
  final Map<String, dynamic> info;
  const ApprovalDetail({super.key, required this.info});

  @override
  State<ApprovalDetail> createState() => _ApprovalDetailState();
}

class _ApprovalDetailState extends State<ApprovalDetail> {
  bool checkApprove = false;
  List<Widget> generateCardTopics(List<dynamic> listPost) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      card.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 40, right: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                border: Border.all(color: ColorConstant.whiteBlack30),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              listPost[i].toString(),
              style: const TextStyle(
                  color: ColorConstant.whiteBlack70, fontSize: 14),
            ),
          ),
        ),
      );
    }
    return card;
  }

  @override
  Widget build(BuildContext context) {
    return TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: true,
        useTemplatescroll: true,
        content: Column(
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
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: InkWell(
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: ColorConstant.whiteBlack70,
                              size: 24,
                            ),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(builder: (context) {
                                return const TemplateApproval();
                              }), (route) => false);
                            },
                          ),
                        ),
                        Builder(builder: ((context) {
                          if (checkApprove == false) {
                            return Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: TextButton(
                                      onPressed: () async {
                                        await context
                                            .read<ApprovalViewModel>()
                                            .approvePost(
                                                true, widget.info["id"]);
                                        setState(() {
                                          checkApprove = true;
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: ColorConstant.white,
                                          backgroundColor:
                                              ColorConstant.green50,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          side: const BorderSide(
                                              color: ColorConstant.green50,
                                              width: 1),
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 8, 16, 8),
                                          alignment: Alignment.center),
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8),
                                            child: Icon(
                                              Icons.check_rounded,
                                              size: 16,
                                            ),
                                          ),
                                          Text("Approve"),
                                        ],
                                      )),
                                ),
                                TextButton(
                                    onPressed: () async {
                                      await context
                                          .read<ApprovalViewModel>()
                                          .approvePost(
                                              false, widget.info["id"]);
                                      setState(() {
                                        checkApprove = true;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                        foregroundColor: ColorConstant.red60,
                                        backgroundColor: ColorConstant.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        side: const BorderSide(
                                            color: ColorConstant.red60,
                                            width: 1),
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 8, 16, 8),
                                        alignment: Alignment.center),
                                    child: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8),
                                          child: Icon(
                                            Icons.clear_rounded,
                                            size: 16,
                                          ),
                                        ),
                                        Text("Disapprove"),
                                      ],
                                    )),
                              ],
                            );
                          } else {
                            //TODO Style
                            return const Text("verified");
                          }
                        })),
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
                                color: ColorConstant.whiteBlack70,
                                fontSize: 16),
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            widget.info["title"],
                            style: const TextStyle(
                                color: ColorConstant.orange70,
                                fontSize: 32,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Text(
                                  widget.info["ownerName"],
                                  style: const TextStyle(
                                      color: ColorConstant.whiteBlack70,
                                      fontSize: 18),
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM')
                                    .format(widget.info["dateCreate"]),
                                style: const TextStyle(
                                    color: ColorConstant.whiteBlack50,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: generateCardTopics(widget.info["topics"]),
                        ),
                        Text(
                          widget.info["detail"],
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack90, fontSize: 20),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
