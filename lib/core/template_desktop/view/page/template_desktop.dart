import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_navbar.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_faq.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_faq_admin.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_help_desk_admin.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_help_desk.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/template_tagbar_home.dart';

class TemplateDesktop extends StatefulWidget {
  final bool faqmenuadmin;
  final bool faqmenu;
  final bool helpdeskadmin;
  final bool helpdesk;
  final bool home;
  final bool useTemplatescroll;
  final Widget content;
  const TemplateDesktop(
      {super.key,
      required this.faqmenu,
      required this.faqmenuadmin,
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

  @override
  Widget build(BuildContext context) {
    bool hasMenu = widget.faqmenu ||
        widget.faqmenuadmin ||
        widget.helpdesk ||
        widget.helpdeskadmin ||
        widget.home;
    double contentSize = 1300;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: const TextSpan(children: [
          TextSpan(text: "Help ", style: AppFontStyle.blue90B36),
          TextSpan(text: "Desk", style: AppFontStyle.orange90B36)
        ])),
        backgroundColor: ColorConstant.white,
        toolbarHeight: 90,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scrollbar(
          controller: horizontal,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: horizontal,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: !hasMenu ? 72 : 400,
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Builder(builder: (context) {
                        if (widget.faqmenu == true) {
                          return const TemplateTagBarFaq();
                        }
                        if (widget.faqmenuadmin == true) {
                          return const TemplateTagBarFaqAdmin();
                        }
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
                      const TemplateNavBar(),
                    ],
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (widget.useTemplatescroll) {
                      return Scrollbar(
                        thumbVisibility: true,
                        controller: childController,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: childController,
                          child: SizedBox(
                              width: screenWidth > contentSize
                                  ? screenWidth - (hasMenu ? 400 : 72)
                                  : contentSize - (hasMenu ? 400 : 72),
                              child: widget.content),
                        ),
                      );
                    }
                    return SizedBox(
                        width: screenWidth > contentSize
                            ? screenWidth - (hasMenu ? 400 : 72)
                            : contentSize - (hasMenu ? 400 : 72),
                        child: widget.content);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: ColorConstant.blue5,
    );
  }
}
