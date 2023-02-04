import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/main_menu.dart';

//Import main_menu.dart
class TemplateNavBar extends StatefulWidget {
  const TemplateNavBar({super.key});

  @override
  State<TemplateNavBar> createState() => _TemplateNavBarState();
}

class _TemplateNavBarState extends State<TemplateNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 24),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(36)),
          color: ColorConstant.white),
      width: 72,
      height: double.infinity,
      child: const MainMenu(),
    );
  }
}
