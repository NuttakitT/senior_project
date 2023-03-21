// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/notification_overlay.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/user_profile/my_profile/view/my_profile_view.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  TextStyle _navbarTextStyle(bool state) => TextStyle(
      fontFamily: AppFontStyle.font,
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: state ? Colors.white : ColorConstant.whiteBlack30);
  final ScrollController _controller = ScrollController();
  bool isNotificationEnabled = false;
  OverlayEntry overlayEntry = OverlayEntry(builder: (builder) {
    return Container();
  });

  Widget _navbar(BuildContext context) {
    bool isHomeSelected =
        context.watch<TemplateDesktopViewModel>().getNavBarState(0);
    bool isHelpDeskSelected =
        context.watch<TemplateDesktopViewModel>().getNavBarState(1);
    bool isTeacherContactSelected =
        context.watch<TemplateDesktopViewModel>().getNavBarState(2);
    bool isRoleManageSelected =
        context.watch<TemplateDesktopViewModel>().getNavBarState(3);
    bool isLogin = context.watch<AppViewModel>().isLogin;
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: InkWell(
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(0, 1);
                    // TODO link to home page
                  },
                  splashFactory: NoSplash.splashFactory,
                  child: Text(
                    "Home",
                    style: _navbarTextStyle(isHomeSelected),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  child: Text(
                    "Help-Desk",
                    style: _navbarTextStyle(isHelpDeskSelected),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(1, 1);
                    int? role =
                        context.read<AppViewModel>().app.getUser.getRole;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HelpDeskMainView(
                                isAdmin: role == 0 ? true : false)),
                        (route) => false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  child: Text(
                    "Teacher Contact",
                    style: _navbarTextStyle(isTeacherContactSelected),
                  ),
                  onTap: () {
                    context.read<TemplateDesktopViewModel>().changeState(2, 1);
                    // TODO link to teacher contact
                  },
                ),
              ),
              Builder(builder: (context) {
                if (isLogin) {
                  bool isAdmin =
                      context.watch<AppViewModel>().app.getUser.getRole == 0;
                  if (isAdmin) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        child: Text(
                          "Role Management",
                          style: _navbarTextStyle(isRoleManageSelected),
                        ),
                        onTap: () {
                          context
                              .read<TemplateDesktopViewModel>()
                              .changeState(3, 1);
                          // TODO link to Role Management
                        },
                      ),
                    );
                  }
                  return Container();
                }
                return Container();
              }),
            ],
          ),
          Builder(builder: (context) {
            if (!isLogin) {
              return TextButton(
                onPressed: () async {
                  bool isSuccess =
                      await context.read<AppViewModel>().login(context);
                  if (isSuccess) {
                    // TODO link to home
                    // Navigator.pushAndRemoveUntil(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return MyProfileView(isAdmin: false,);
                    //   }),
                    // (route) => false);
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorConstant.orange70),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10.5)),
                    maximumSize: MaterialStateProperty.all(const Size(227, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: const Text(
                  "Login with KMUTT account",
                  style: TextStyle(
                      fontFamily: AppFontStyle.font,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 28),
                    child: InkWell(
                      child: const Icon(
                        Icons.notifications_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          isNotificationEnabled = !isNotificationEnabled;
                        });
                        Future.delayed(Duration.zero, () {
                          _showNotifications(context, isNotificationEnabled);
                        });
                      },
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    onTap: () {
                      // TODO pop-up
                    },
                  )
                ],
              ),
            );
          })
        ]);
  }

  void _showNotifications(BuildContext context, bool isOpen) async {
    OverlayState? overlayState = Overlay.of(context);
    if (isOpen) {
      overlayEntry = OverlayEntry(
          builder: (BuildContext context) => const Positioned(
              top: 76.0, right: 100.0, child: NotificationOverlay()));
      overlayState?.insert(overlayEntry);
    } else {
      overlayEntry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 80),
      child: Builder(
        builder: (context) {
          if (screenWidth < 935) {
            return Scrollbar(
              controller: _controller,
              child: SingleChildScrollView(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                child: _navbar(context),
              ),
            );
          }
          return _navbar(context);
        },
      ),
    );
  }
}
