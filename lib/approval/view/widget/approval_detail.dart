import 'package:flutter/material.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:provider/provider.dart';
import '../../../assets/color_constant.dart';
import '../../model/approval_model.dart';
import '../page/template_approval.dart';

class ApprovalDetail extends StatefulWidget {
  final Map<String, dynamic> info;
  const ApprovalDetail({super.key, required this.info});

  @override
  State<ApprovalDetail> createState() => _ApprovalDetailState();
}

class _ApprovalDetailState extends State<ApprovalDetail> {
  // final List<bool> _select = <bool>[true, false];
  // bool vertical = false;
  bool isApproved = false;

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
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: TextButton(
                          onPressed: () async {
                            setState(() {
                              isApproved = true;
                            });
                            final request =
                                ApprovalRequset(isApproval: isApproved);
                            //TODO save this post to database
                            // await context
                            //     .read<ApprovalViewModel>()
                            //     .approvalPost(request, context);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: ColorConstant.white,
                              backgroundColor: ColorConstant.green50,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              side: const BorderSide(
                                  color: ColorConstant.green50, width: 1),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                        onPressed: () {
                          //TODO save this post to database (unapprove)
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: ColorConstant.red60,
                            backgroundColor: ColorConstant.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            side: const BorderSide(
                                color: ColorConstant.red60, width: 1),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
                    // ToggleButtons(
                    //   children: <Widget>[Text("Approve"), Text("Disapprove")],
                    //   borderRadius: const BorderRadius.all(Radius.circular(8)),
                    //   selectedBorderColor: ColorConstant.orange60,
                    //   selectedColor: ColorConstant.orange40,
                    //   fillColor: ColorConstant.orange5,
                    //   color: ColorConstant.whiteBlack60,
                    //   constraints:
                    //       const BoxConstraints(minHeight: 40, minWidth: 80),
                    //   isSelected: _select,
                    //   direction: vertical ? Axis.vertical : Axis.horizontal,
                    //   onPressed: ((int index) {
                    //     setState(
                    //       () {
                    //         for (int i = 0; i < _select.length; i++) {
                    //           _select[i] = i == index;
                    //         }
                    //       },
                    //     );
                    //   }),
                    // ),
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
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
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
                        child: Text(
                          widget.info["topic"],
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 18),
                        ),
                      ),
                    ),
                    //TODO detail
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
    );
  }
}
