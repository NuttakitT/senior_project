import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/user_authentication/login_register_page/view/page/authentication_page.dart';
import 'package:senior_project/user_authentication/my_profile/view/my_profile_view.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  BoxBorder? borderStyle(bool isSelected) {
    if (isSelected) {
      return const Border(
        left: BorderSide(
            width: 4, color: ColorConstant.orange40
        )
      );
    }
    return null;
  }

  Color colorStyle(bool isSelected) {
    if (isSelected) {
      return ColorConstant.orange10;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    bool isHomeSelected = context.watch<TemplateDesktopViewModel>().getNavBarState(0);
    bool isHelpDeskSelected = context.watch<TemplateDesktopViewModel>().getNavBarState(1);
    bool isRoomSelected = context.watch<TemplateDesktopViewModel>().getNavBarState(2);
    bool isTeacherContactSelected = context.watch<TemplateDesktopViewModel>().getNavBarState(3);
    bool isFaqSelected = context.watch<TemplateDesktopViewModel>().getNavBarState(4);
    bool isProfileSelected = context.watch<TemplateDesktopViewModel>().getNavBarState(5);
    bool isLogin = context.watch<AppViewModel>().hasUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Container(
                decoration: BoxDecoration(
                  border: borderStyle(isHomeSelected),
                  color: colorStyle(isHomeSelected)
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: InkWell(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: ColorConstant.orange5),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.home_rounded,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(0, 1);
                    // TODO link to home page
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration:  BoxDecoration(
                  border: borderStyle(isHelpDeskSelected),
                  color: colorStyle(isHelpDeskSelected)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                //finish
                child: InkWell(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: ColorConstant.orange5),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.table_restaurant_rounded,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(1, 1);
                    int? role = context.read<AppViewModel>().app.getUser.getRole;
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => 
                        HelpDeskMainView(isAdmin: role == 0
                          ? true 
                          : false
                        )
                      )
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                    border: borderStyle(isRoomSelected),
                    color: colorStyle(isRoomSelected)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: InkWell(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: ColorConstant.orange5),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.meeting_room_rounded,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(2, 1);
                    // TODO link to room reservation page
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                    border: borderStyle(isTeacherContactSelected),
                    color: colorStyle(isTeacherContactSelected)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: InkWell(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: ColorConstant.orange5),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.contacts_rounded,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(3, 1);
                    // TODO link to teacher contact page
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                decoration: BoxDecoration(
                    border: borderStyle(isFaqSelected),
                    color: colorStyle(isFaqSelected)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: InkWell(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: ColorConstant.orange5),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.contact_support_rounded,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(4, 1);
                    // TODO link to FAQ page
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                    border: borderStyle(isProfileSelected),
                    color: colorStyle(isProfileSelected)),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: InkWell(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360),
                        color: ColorConstant.orange5),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.face,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(5, 1);
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) {
                        return MyProfileView();
                      }), 
                      (route) => false
                    );
                  },
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: ColorConstant.orange5),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(
                      isLogin ? Icons.logout_rounded : Icons.login_rounded,
                      color: ColorConstant.orange70,
                    ),
                  ),
                ),
                onTap: () {
                  if (isLogin) {
                    context.read<AppViewModel>().logout();
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (context) {
                        return const AuthenticationPage();
                      }), 
                      (route) => false
                    );
                  }
                },
              ),
            ),
          ],
        )
      ]
    );
  }
}
