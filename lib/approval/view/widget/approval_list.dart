import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view/widget/content.dart';
import 'package:senior_project/approval/view/widget/header.dart';
import 'package:senior_project/approval/view/widget/text_search_result.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class ApprovalList extends StatefulWidget {
  const ApprovalList({super.key});

  @override
  State<ApprovalList> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
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
              Builder(
                builder: (context) {
                  String searchText = context.watch<TextSearch>().getSearchText;
                  if (searchText.isNotEmpty) {
                    return const TextSearchResult();
                  }
                  return const Header(content: Content(isTextSearch: false,),);
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
