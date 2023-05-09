import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class EditProfileMobile extends StatefulWidget {
  const EditProfileMobile({super.key});

  @override
  State<EditProfileMobile> createState() => _EditProfileMobileState();
}

class _EditProfileMobileState extends State<EditProfileMobile> {
  XFile? pickedFile;
  Uint8List? imageFile;
  bool hasImage = false;

  @override
  Widget build(BuildContext context) {
    String name = context.read<AppViewModel>().app.getUser.getName;
    String? phone = context.read<AppViewModel>().app.getUser.getPhone;
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    String? email = context.watch<AppViewModel>().app.getUser.getEmail;
    String? imageUrl =
        context.watch<AppViewModel>().app.getUser.getProfileImageUrl;

    return TemplateMenuMobile(
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                Material(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
                const Center(
                    child: DefaultTextStyle(
                        style: AppFontStyle.wb80Md28,
                        child: Text('Edit Profile')))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Builder(builder: (context) {
                  if (imageUrl != null) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        imageUrl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                    );
                  }
                  return Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: ColorConstant.blue40,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: ColorConstant.whiteBlack90,
                      size: 76,
                    ),
                  );
                }),
                const SizedBox(height: 16),
                DefaultTextStyle(
                    style: AppFontStyle.wb80Md28, child: Text(name)),
                const SizedBox(height: 8),
                Builder(builder: (context) {
                  if (hasImage) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextButton(
                            onPressed: () async {
                              await context
                                  .read<TemplateDesktopViewModel>()
                                  .uploadImage(
                                      imageFile, pickedFile!.name, uid);
                              // ignore: use_build_context_synchronously
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
                                      borderRadius: BorderRadius.circular(16))),
                              backgroundColor: MaterialStateProperty.all(
                                  ColorConstant.white),
                              side: MaterialStateProperty.all(const BorderSide(
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
                        side: MaterialStateProperty.all(
                            const BorderSide(color: ColorConstant.orange50)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        fixedSize:
                            MaterialStateProperty.all(const Size(150, 40))),
                    child: const Text(
                      "Uplaod",
                      style: TextStyle(
                          fontFamily: AppFontStyle.font,
                          fontWeight: AppFontWeight.bold,
                          fontSize: 16,
                          color: ColorConstant.orange50),
                    ),
                  );
                }),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DefaultTextStyle(
                        style: AppFontStyle.wb60R18, child: Text('Email')),
                    const SizedBox(height: 12),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.whiteBlack30),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DefaultTextStyle(
                            style: AppFontStyle.wb70R16, child: Text(email))),
                    const SizedBox(height: 24),
                    const DefaultTextStyle(
                        style: AppFontStyle.wb60R18, child: Text('Phone')),
                    const SizedBox(height: 12),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstant.whiteBlack30),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DefaultTextStyle(
                            style: AppFontStyle.wb70R16,
                            child: Text(phone ?? "")))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
