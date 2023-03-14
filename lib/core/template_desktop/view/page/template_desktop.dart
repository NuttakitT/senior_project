import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/main_menu.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_help_desk_admin.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_help_desk.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_home.dart';

class TemplateDesktop extends StatefulWidget {
  final bool helpdeskadmin;
  final bool helpdesk;
  final bool home;
  final bool useTemplatescroll;
  final Widget content;
  const TemplateDesktop(
      {super.key,
      required this.helpdesk,
      required this.helpdeskadmin,
      required this.home,
      required this.useTemplatescroll,
      required this.content});

  @override
  State<TemplateDesktop> createState() => _TemplateDesktopState();
}

class _TemplateDesktopState extends State<TemplateDesktop> {
  ScrollController horizontal = ScrollController();
  ScrollController vertical = ScrollController();
  ScrollController childController = ScrollController();

  Widget _content(Widget content, double screenWidth, double height) {
    bool hasMenu = widget.helpdesk 
      || widget.helpdeskadmin 
      || widget.home;
    double contentSize = 1112;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/desktop_background.png"),
          fit: BoxFit.cover
        )
      ),
      height: height,
      width: hasMenu 
        ? (screenWidth - 328) > contentSize
          ? screenWidth - 328
          : contentSize
        : screenWidth > 1440
          ? screenWidth
          : 1440,
      child: widget.content
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 90;

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Image.asset('assets/images/icon.png'),
        ),
        leadingWidth: 180,
        title: const SizedBox(
          height: 85,
          child: MainMenu()
        ),
        backgroundColor: ColorConstant.whiteBlack90,
        toolbarHeight: 90,
      ),
      body: SizedBox(
        width: screenWidth,
        height: double.infinity,
        child: Scrollbar(
          controller: horizontal,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: horizontal,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Builder(builder: (context) {
                  if (widget.helpdesk == true) {
                    return const TemplateTagBarHelpDesk();
                  }
                  if (widget.helpdeskadmin == true) {
                    return const TemplateTagBarHelpDeskAdmin();
                  }
                  if (widget.home == true) {
                    return const TemplateTagBarHome();
                  }
                  return Container();
                }),
                Builder(
                  builder: (context) {
                    if (widget.useTemplatescroll) {
                      return Scrollbar(
                        thumbVisibility: true,
                        controller: childController,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: childController,
                          child: _content(widget.content, screenWidth, screenHeight),
                        ),
                      );
                    }
                    return _content(widget.content, screenWidth, screenHeight);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
