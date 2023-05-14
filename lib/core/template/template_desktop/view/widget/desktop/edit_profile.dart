// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? pickedFile;
  Uint8List? imageFile;
  bool hasImage = false;

  @override
  Widget build(BuildContext context) {
    String? phone = context.read<AppViewModel>().app.getUser.getPhone;
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    String? imageUrl =
        context.watch<AppViewModel>().app.getUser.getProfileImageUrl;
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
                    bottom: BorderSide(color: ColorConstant.whiteBlack20))),
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
                      color: ColorConstant.orange60),
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
                        shape: BoxShape.circle),
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
                  child: Builder(builder: (context) {
                    if (imageUrl != null) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          imageUrl,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      );
                    }
                    return Container(
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
                    );
                  }),
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
                            color: ColorConstant.whiteBlack80),
                      ),
                    ),
                    Builder(builder: (context) {
                      if (hasImage) {
                        return Row(
                          children: [
                            Text(
                              pickedFile!.name,
                              style: const TextStyle(
                                  fontFamily: AppFontStyle.font,
                                  fontWeight: AppFontWeight.bold,
                                  fontSize: 16,
                                  color: ColorConstant.whiteBlack70),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextButton(
                                onPressed: () async {
                                  String? url = await context
                                      .read<TemplateDesktopViewModel>()
                                      .uploadImage(
                                          imageFile, pickedFile!.name, uid);
                                  context.read<AppViewModel>().app.getUser.setProfileImageUrl = url;
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16))),
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorConstant.orange70),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(16))),
                                child: const Text(
                                  "Confirm",
                                  style: TextStyle(
                                      fontFamily: AppFontStyle.font,
                                      fontWeight: AppFontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  hasImage = false;
                                });
                                imageFile = null;
                                pickedFile = null;
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorConstant.white),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: ColorConstant.orange70)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(16))),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                    fontFamily: AppFontStyle.font,
                                    fontWeight: AppFontWeight.bold,
                                    fontSize: 16,
                                    color: ColorConstant.orange70),
                              ),
                            ),
                          ],
                        );
                      }
                      return TextButton(
                        onPressed: () async {
                          pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            imageFile = await pickedFile!.readAsBytes();
                            setState(() {
                              hasImage = true;
                            });
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: ColorConstant.orange50)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            fixedSize:
                                MaterialStateProperty.all(const Size(150, 40))),
                        child: const Text(
                          "Upload",
                          style: TextStyle(
                              fontFamily: AppFontStyle.font,
                              fontWeight: AppFontWeight.bold,
                              fontSize: 16,
                              color: ColorConstant.orange50),
                        ),
                      );
                    })
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
                        color: ColorConstant.whiteBlack60),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorConstant.whiteBlack30),
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    context.read<AppViewModel>().app.getUser.getEmail,
                    style: const TextStyle(
                        fontFamily: AppFontStyle.font,
                        fontWeight: AppFontWeight.regular,
                        fontSize: 18,
                        color: ColorConstant.whiteBlack70),
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
                      color: ColorConstant.whiteBlack60),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.whiteBlack30),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  phone ?? "-",
                  style: const TextStyle(
                      fontFamily: AppFontStyle.font,
                      fontWeight: AppFontWeight.regular,
                      fontSize: 18,
                      color: ColorConstant.whiteBlack70),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
