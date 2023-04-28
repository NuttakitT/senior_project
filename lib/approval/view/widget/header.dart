import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/approval/view_model/approval_view_model.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';

class Header extends StatefulWidget {
  final Widget content;
  const Header({super.key, required this.content});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(2);
    Map<String, dynamic> tagBarName = context.read<TemplateDesktopViewModel>().getHomeTagBarNameSelected(tagBarSelected);
    context.read<ApprovalViewModel>().setIsSafeClick = false;

    return FutureBuilder(
      future: context.read<ApprovalViewModel>().getPostAll(
        tagBarSelected != 0 ? tagBarName["name"] : ""
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }
        context.read<ApprovalViewModel>().setIsSafeClick = true;
        int postNumber = context.read<ApprovalViewModel>().getPost.length;
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
                      if (postNumber == 0) {
                        return Container();
                      }
                      return Text(
                        postNumber.toString(),
                        style: const TextStyle(
                            color: ColorConstant.whiteBlack70,
                            fontSize: 16),
                      );
                    }
                  )
                ],
              ),
            ),
            widget.content,
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
                      if (postNumber == 0) {
                        return Container();
                      }
                      return Text(
                        postNumber.toString(),
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
    );
  }
}