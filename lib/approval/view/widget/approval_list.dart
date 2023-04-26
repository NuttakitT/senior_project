import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view/widget/card_approval.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/color_constant.dart';

class ApprovalList extends StatefulWidget {
  const ApprovalList({super.key});

  @override
  State<ApprovalList> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  List<Widget> generateCardApproval(List<Map<String, dynamic>> listPost) {
    List<Widget> card = [];
    for (int i = 0; i < listPost.length; i++) {
      card.add(CardApproval(
        info: listPost[i],
        checknumcard: i,
      ));
    }
    return card;
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              FutureBuilder(
                  future: context.read<ApprovalViewModel>().getPostAll(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      int paginate =
                          context.read<ApprovalViewModel>().getPost.length;
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                            decoration: const BoxDecoration(
                                color: ColorConstant.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16))),
                            child: Row(
                              children: [
                                InkWell(
                                  child: const Icon(
                                    Icons.refresh_rounded,
                                    color: ColorConstant.whiteBlack70,
                                    size: 24,
                                  ),
                                  onTap: () {
                                    setState(() {});
                                  },
                                ),
                                const Spacer(),
                                Text(
                                  paginate.toString(),
                                  style: const TextStyle(
                                      color: ColorConstant.whiteBlack70,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                          Column(
                              children: generateCardApproval(
                                  context.watch<ApprovalViewModel>().getPost)),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 24, 16, 24),
                            decoration: const BoxDecoration(
                                color: ColorConstant.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
                            child: Row(
                              children: [
                                const Spacer(),
                                Text(
                                  paginate.toString(),
                                  style: const TextStyle(
                                      color: ColorConstant.whiteBlack70,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  })),
            ],
          ),
        ),
      ],
    );
  }
}
