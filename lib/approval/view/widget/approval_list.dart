import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view/widget/card_approval.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';

class ApprovalList extends StatefulWidget {
  const ApprovalList({super.key});

  @override
  State<ApprovalList> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  List<Widget> generateCardApproval(List<Map<String, dynamic>> listPost) {
    context.read<TemplateDesktopViewModel>().setIsSafeClick = false;
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
    context.read<TemplateDesktopViewModel>().setIsSafeClick = false;
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(2);
    Map<String, dynamic> tagBarName = context.read<TemplateDesktopViewModel>().getHomeTagBarNameSelected(tagBarSelected);
    context.read<ApprovalViewModel>().setIsSafeClick = false;

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
                  future: context.read<ApprovalViewModel>().getPostAll(
                    tagBarSelected != 0 ? tagBarName["name"] : ""
                  ),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      context.read<ApprovalViewModel>().setIsSafeClick = true;
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
                                Builder(
                                  builder: (context) {
                                    if (paginate == 0) {
                                      return Container();
                                    }
                                    return Text(
                                      paginate.toString(),
                                      style: const TextStyle(
                                          color: ColorConstant.whiteBlack70,
                                          fontSize: 16),
                                    );
                                  }
                                )
                              ],
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              if (context.watch<ApprovalViewModel>().getPost.length != 0) {
                                return Column(
                                  children: generateCardApproval(
                                      context.watch<ApprovalViewModel>().getPost));
                              }
                              return Container(
                                width: double.infinity,
                                height: 58,
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: ColorConstant.white,
                                  border: Border(
                                      top: BorderSide(color: ColorConstant.whiteBlack30),
                                      bottom: BorderSide(color: ColorConstant.whiteBlack30)
                                  )
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  "No post in this category", 
                                  style:  TextStyle(
                                    fontFamily: AppFontStyle.font,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: ColorConstant.whiteBlack60
                                  ),),
                              );
                            }
                          ),
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
                                Builder(
                                  builder: (context) {
                                    if (paginate == 0) {
                                      return Container();
                                    }
                                    return Text(
                                      paginate.toString(),
                                      style: const TextStyle(
                                          color: ColorConstant.whiteBlack70,
                                          fontSize: 16),
                                    );
                                  }
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
