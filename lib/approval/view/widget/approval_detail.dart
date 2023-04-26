// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import '../../../assets/color_constant.dart';
import '../page/template_approval.dart';
import 'package:intl/intl.dart';

class ApprovalDetail extends StatefulWidget {
  final int checknumcard;
  const ApprovalDetail({super.key, required this.checknumcard});

  @override
  State<ApprovalDetail> createState() => _ApprovalDetailState();
}

class _ApprovalDetailState extends State<ApprovalDetail> {
  bool checkApprove = false;
  int checknum = 0;
  @override
  void initState() {
    super.initState();
    checknum = widget.checknumcard;
  }

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
    int paginate = context.read<ApprovalViewModel>().getPost.length;
    Map<String, dynamic> info =
        context.read<ApprovalViewModel>().getPost[checknum];
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
                                            .approvePost(true, info["id"]);
                                        for (int i = 0;
                                            i < info["topics"].length;
                                            i++) {
                                          await context
                                              .read<ApprovalViewModel>()
                                              .approveTopic(true,
                                                  info["topics"][i].toString());
                                        }
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
                                          .approvePost(false, info["id"]);
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
                            return const Text(
                              "verified",
                              style: TextStyle(
                                  color: ColorConstant.green50,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            );
                          }
                        })),
                        const Spacer(),
                        Builder(builder: (context) {
                          if (checknum == 0) {
                            return Container();
                          }
                          return InkWell(
                            child: const Icon(
                              Icons.keyboard_arrow_left_rounded,
                              color: ColorConstant.whiteBlack60,
                              size: 24,
                            ),
                            onTap: () {
                              setState(() {
                                checknum--;
                              });
                            },
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Text(
                            "${checknum + 1} of $paginate",
                            style: const TextStyle(
                                color: ColorConstant.whiteBlack70,
                                fontSize: 16),
                          ),
                        ),
                        Builder(builder: (context) {
                          if (checknum == paginate - 1) {
                            return Container();
                          }
                          return InkWell(
                            child: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: ColorConstant.whiteBlack60,
                              size: 24,
                            ),
                            onTap: () {
                              setState(() {
                                checknum++;
                              });
                            },
                          );
                        })
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
                            info["title"],
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
                                  info["ownerName"],
                                  style: const TextStyle(
                                      color: ColorConstant.whiteBlack70,
                                      fontSize: 18),
                                ),
                              ),
                              Text(
                                DateFormat('dd MMM').format(info["dateCreate"]),
                                style: const TextStyle(
                                    color: ColorConstant.whiteBlack50,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: generateCardTopics(info["topics"]),
                        ),
                        Text(
                          info["detail"],
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
