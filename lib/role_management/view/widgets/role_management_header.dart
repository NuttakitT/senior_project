import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/role_management/view_model/role_management_view_model.dart';

class RoleManagementHeader extends StatelessWidget {
  final String title;
  final bool isSearchEnabled;
  final String buttonLabel;
  final Widget popup;
  const RoleManagementHeader(
      {super.key,
      required this.title,
      required this.isSearchEnabled,
      required this.buttonLabel,
      required this.popup});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 64),
      child: Row(
        children: [
          DefaultTextStyle(style: AppFontStyle.wb90Md32, child: Text(title)),
          const Spacer(),
          if (isSearchEnabled)
            Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorConstant.white),
              child: TextField(
                decoration: const InputDecoration(
                    hintText: "search...",
                    hintStyle: TextStyle(
                        color: ColorConstant.whiteBlack30, fontSize: 16),
                    counterText: "",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide.none,
                        gapPadding: 0)),
                onChanged: (value) {
                  context.read<RoleManagementViewModel>().setSearchText(value);
                },
              ),
            ),
          const SizedBox(width: 16),
          SizedBox(
            width: 178,
            height: 40,
            child: TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return popup;
                    });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorConstant.orange40),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    buttonLabel,
                    style: AppFontStyle.whiteSemiB16,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
