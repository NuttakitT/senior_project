// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/edit_profile.dart';
import 'package:senior_project/core/template/template_desktop/view/widget/desktop/notification_overlay.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/role_management/view/role_management_view.dart';

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
                    context.read<TemplateDesktopViewModel>().changeState(context, 0, 1);
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
                    context.read<TemplateDesktopViewModel>().changeState(context, 1, 1);
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
                    context.read<TemplateDesktopViewModel>().changeState(context, 2, 1);
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
                              .changeState(context, 3, 1);
                          Navigator.pushAndRemoveUntil(
                            context, 
                            MaterialPageRoute(builder: (context) {
                              return RoleManagementView(isAdmin: isAdmin);
                            }), 
                            (route) => false
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                }
                return Container();
              }
            ),
          ],
        ),
        Builder(builder: (context) {
          if (!isLogin) {
            return TextButton(
              onPressed: () async {
                bool isSuccess = await context.read<AppViewModel>().login(context);
                if (isSuccess) {
                  // TODO link to home
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (context) {
                      return HelpDeskMainView(
                        isAdmin: context.read<AppViewModel>().app.getUser.getRole == 0 ? true : false,
                      );
                    }), 
                  (route) => false);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  ColorConstant.orange70
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10.5)
                ),
                fixedSize: MaterialStateProperty.all(
                  const Size(227, 40)
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  )
                ) 
              ),
              child: const Text(
                "Login with KMUTT account",
                style: TextStyle(
                  fontFamily: AppFontStyle.font,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white
                ),
              ));
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
                  PopupMenuButton(
                    padding: const EdgeInsets.all(0),
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
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          enabled: false,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: ColorConstant.whiteBlack30
                                )
                              ),
                              color: Colors.white
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    "Account",
                                    style: TextStyle(
                                      fontFamily: AppFontStyle.font,
                                      fontWeight: AppFontWeight.medium,
                                      fontSize: 16,
                                      color: ColorConstant.whiteBlack90
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle, 
                                        color: Colors.white,
                                        border: Border.all(
                                          color: ColorConstant.orange90
                                        )
                                      ),
                                      child: const Icon(
                                        Icons.person_rounded,
                                        color: ColorConstant.orange80,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            context.read<AppViewModel>().app.getUser.getName,
                                            style: const TextStyle(
                                              fontFamily: AppFontStyle.font,
                                              fontWeight: AppFontWeight.regular,
                                              fontSize: 14,
                                              color: ColorConstant.whiteBlack90
                                            ),
                                          ),
                                          Text(
                                            context.read<AppViewModel>().app.getUser.getEmail,
                                            style: const TextStyle(
                                              fontFamily: AppFontStyle.font,
                                              fontWeight: AppFontWeight.regular,
                                              fontSize: 12,
                                              color: ColorConstant.whiteBlack70
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(
                              const Duration(seconds: 0),
                              () => showDialog(
                                context: context, 
                                builder: (context) {
                                  return const EditProfile();
                                }
                              )
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.create_rounded, 
                                    color: ColorConstant.whiteBlack80,
                                  ),
                                ),
                                Text(
                                  "Edit Profile",
                                  style: TextStyle(
                                    fontFamily: AppFontStyle.font,
                                    fontSize: 14,
                                    fontWeight: AppFontWeight.regular,
                                    color: ColorConstant.whiteBlack80
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            await context.read<AppViewModel>().logout();
                            // TODO push to home
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.logout_rounded, 
                                    color: ColorConstant.whiteBlack80,
                                  ),
                                ),
                                Text(
                                  "Log out",
                                  style: TextStyle(
                                    fontFamily: AppFontStyle.font,
                                    fontSize: 14,
                                    fontWeight: AppFontWeight.regular,
                                    color: ColorConstant.whiteBlack80
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ];
                    },
                  ),
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
          if (screenWidth < 1025) {
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
