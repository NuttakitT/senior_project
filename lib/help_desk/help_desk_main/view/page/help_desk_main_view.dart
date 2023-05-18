import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template/template_mobile/view/template_menu_mobile.dart';
import 'package:senior_project/core/template/template_mobile/view_model/template_mobile_view_model.dart';
import 'package:senior_project/core/template/widget/search_bar.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/body.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/header.dart';
import 'package:senior_project/help_desk/help_desk_main/view/mobile/mobile_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class HelpDeskMainView extends StatefulWidget {
  final bool isAdmin;
  const HelpDeskMainView({super.key, required this.isAdmin});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {
  String selectedValue = "All Ticket";
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    // bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    // double screenHeight = MediaQuery.of(context).size.height;
    int? role = context.watch<AppViewModel>().app.getUser.getRole;
    bool isLogin = context.watch<AppViewModel>().isLogin;
    // context.read<HelpDeskViewModel>().setIsMobile = isMobileSite;

    List<String> list = ["All Ticket", "Not Start", "In Progress", "Closed"];

    return FutureBuilder(
      future: context.read<HelpDeskViewModel>().initTicketCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (isMobileSite) {
            context.read<TemplateMobileViewModel>().changeMenuState(1);
            return TemplateMenuMobile(content: Builder(builder: (context) {
              if (!isLogin) {
                return const Center(
                  child: Text(
                    "Please login to use the services",
                    style: TextStyle(
                        color: ColorConstant.orange60,
                        fontWeight: FontWeight.w400,
                        fontFamily: AppFontStyle.font,
                        fontSize: 18),
                  ),
                );
              }
              return MobileWidget(
                isAdmin: role == 0 ? true : false,
              );
            }));
          }
          context.read<TemplateDesktopViewModel>().changeState(context, 1, 1);
          return TemplateDesktop(
              helpdesk: !widget.isAdmin,
              helpdeskadmin: widget.isAdmin,
              home: false,
              useTemplatescroll: false,
              content: Builder(builder: (context) {
                if (!isLogin) {
                  return const Center(
                    child: Text(
                      "Please login to use the services",
                      style: TextStyle(
                          color: ColorConstant.orange60,
                          fontWeight: FontWeight.w400,
                          fontFamily: AppFontStyle.font,
                          fontSize: 24),
                    ),
                  );
                }
                return Container(
                  alignment: AlignmentDirectional.topCenter,
                  child: Builder(builder: (context) {
                    // if (screenHeight < 500) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Header.widget(context, widget.isAdmin),
                          Padding(
                            padding: const EdgeInsets.only(left: 43, bottom: 40, right: 40),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 6),
                                  child: Icon(Icons.filter_alt_rounded, size: 16, color: ColorConstant.whiteBlack60,),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Filter",
                                    style: TextStyle(
                                      fontWeight: AppFontWeight.regular,
                                      fontSize: 20,
                                      color: ColorConstant.whiteBlack60
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: ColorConstant.whiteBlack40),
                                    color: Colors.white
                                  ),
                                  width: 300,
                                  height: 40,
                                  alignment: Alignment.center,
                                  child: DropdownButton<String>(
                                    underline: Container(),
                                    isExpanded: true,
                                    value: selectedValue,
                                    items: list.map((e) {
                                      return DropdownMenuItem<String>(
                                        value: e,
                                        child: Text(e)
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                      context.read<HelpDeskViewModel>().setIsFormNoti = false;
                                      context.read<TemplateDesktopViewModel>().changeState(context, list.indexOf(selectedValue), 4);
                                      context.read<HelpDeskViewModel>().setShowMessagePageState(false);
                                      context.read<HelpDeskViewModel>().clearContentController();
                                      context.read<HelpDeskViewModel>().clearModel();
                                      context.read<HelpDeskViewModel>().clearReplyDocId();
                                    }
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: ColorConstant.whiteBlack40),
                                  ),
                                  width: 280,
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: const SearchBar(
                                    isHelpDeskPage: true
                                  )
                                )
                              ],
                            ),
                          ),
                          Body(
                            isAdmin: widget.isAdmin,
                          )
                        ],
                      ),
                    );
                    // }
                    // return Column(
                    //   children: [
                    //     Header.widget(context, widget.isAdmin),
                    //     Body(
                    //       isAdmin: widget.isAdmin,
                    //     )
                    //   ],
                    // );
                  }),
                );
              }));
        }
        return Container();
      },
    );
  }
}
