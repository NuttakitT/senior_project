import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/main_menu.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/tagbar.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/template_tagbar_help_desk_admin.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/template_tagbar_help_desk.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/template_tagbar_home.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

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
  ScrollController menuScoolController = ScrollController();
  ScrollController childController = ScrollController();

  Widget _content(Widget content, double screenWidth, {double? height}) {
    bool hasMenu = widget.helpdesk || widget.helpdeskadmin || widget.home;
    double contentSize = 1112;

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/desktop_background.png"),
                fit: BoxFit.cover)),
        height: height,
        width: hasMenu
            ? (screenWidth - 328) > contentSize
                ? screenWidth - 328
                : contentSize
            : screenWidth > 1440
                ? screenWidth
                : 1440,
        child: Builder(
          builder: (context) {
            if (widget.useTemplatescroll) {
              return Scrollbar(
                controller: childController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: childController,
                  scrollDirection: Axis.vertical,
                  child: widget.content,
                ),
              );
            }
            return widget.content;
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;

    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Image.asset('assets/images/icon.png'),
        ),
        leadingWidth: 180,
        title: const Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 85, 
            child: MainMenu()
          )
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
                // Builder(builder: (context) {
                //   if (widget.helpdesk == true) {
                //     return const TemplateTagBarHelpDesk();
                //   }
                //   if (widget.helpdeskadmin == true) {
                //     return const TemplateTagBarHelpDeskAdmin();
                //   }
                //   if (widget.home == true) {
                //     return const TemplateTagBarHome();
                //   }
                //   return Container();
                // }),
                Container(
                  color: ColorConstant.whiteBlack85,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    controller: menuScoolController,
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 40, bottom: 8),
                          child: TagBar(
                            name: "Home", 
                            index: 0, 
                            type: 1
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: TagBar(
                            name: "Helpdesk", 
                            index: 1, 
                            type: 1
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (!isAdmin) {
                              return Container();
                            }
                            return const Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 8),
                              child: TagBar(
                                name: "Role Management", 
                                index: 2, 
                                type: 1
                              ),
                            );
                          }
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: TagBar(
                            name: "Teacher Contact", 
                            index: 3, 
                            type: 1
                          ),
                        ),
                        Container(
                          width: 326,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Text(
                                  "Facility",
                                  style: TextStyle(
                                      fontFamily: AppFontStyle.font,
                                      color: ColorConstant.white,
                                      fontWeight: AppFontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TagBar(
                            name: "Room booking", 
                            index: 4, 
                            type: 1
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TagBar(
                            name: "Equipment booking", 
                            index: 5, 
                            type: 1
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                          child: TagBar(
                            name: "My booking", 
                            index: 6, 
                            type: 1
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (!isAdmin) {
                              return Container();
                            }
                            return const Padding(
                              padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                              child: TagBar(
                                name: "Schedule room", 
                                index: 7, 
                                type: 1
                              ),
                            );
                          }
                        ),
                        Builder(
                          builder: (context) {
                            if (!isAdmin) {
                              return Container();
                            }
                            return Column(
                              children: [
                                Container(
                                  width: 326,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Text(
                                          "Statistic Report",
                                          style: TextStyle(
                                              fontFamily: AppFontStyle.font,
                                              color: ColorConstant.white,
                                              fontWeight: AppFontWeight.bold,
                                              fontSize: 20),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                  child: TagBar(
                                    name: "Help-desk system", 
                                    index: 8, 
                                    type: 1
                                  ),
                                ),
                                // const Padding(
                                //   padding: EdgeInsets.only(left: 8, top: 8, bottom: 8),
                                //   child: TagBar(
                                //     name: "Room reservation", 
                                //     index: 9, 
                                //     type: 1
                                //   ),
                                // ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return _content(widget.content, screenWidth,
                        height: double.infinity);
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
