import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    String? phone = context.read<AppViewModel>().app.getUser.getPhone;
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorConstant.whiteBlack20)
              )
            ),
            padding: const EdgeInsets.fromLTRB(0, 24, 24, 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: AppFontWeight.bold,
                    fontSize: 28,
                    color: ColorConstant.orange60
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteBlack70,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: ColorConstant.blue40,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: ColorConstant.whiteBlack90,
                      size: 70,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        context.read<AppViewModel>().app.getUser.getName,
                        style: const TextStyle(
                          fontFamily: AppFontStyle.font,
                          fontWeight: AppFontWeight.medium,
                          fontSize: 28,
                          color: ColorConstant.whiteBlack80
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO upload picture
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: ColorConstant.orange50)
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          )
                        ),
                        fixedSize: MaterialStateProperty.all(
                          const Size(150, 40)
                        )
                      ),
                      child: const Text(
                        "Uplaod",
                        style: TextStyle(
                          fontFamily: AppFontStyle.font,
                          fontWeight: AppFontWeight.bold,
                          fontSize: 16,
                          color: ColorConstant.orange50
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    "E-mail",
                    style: TextStyle(
                      fontFamily: AppFontStyle.font,
                      fontWeight: AppFontWeight.regular,
                      fontSize: 18,
                      color: ColorConstant.whiteBlack60
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.whiteBlack30),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    context.read<AppViewModel>().app.getUser.getEmail,
                    style: const TextStyle(
                      fontFamily: AppFontStyle.font,
                      fontWeight: AppFontWeight.regular,
                      fontSize: 18,
                      color: ColorConstant.whiteBlack70
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  "Phone",
                  style: TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: AppFontWeight.regular,
                    fontSize: 18,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstant.whiteBlack30),
                  borderRadius: BorderRadius.circular(8)
                ),
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  phone == "null"
                  ? "-"
                  : phone!,
                  style: const TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: AppFontWeight.regular,
                    fontSize: 18,
                    color: ColorConstant.whiteBlack70
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}