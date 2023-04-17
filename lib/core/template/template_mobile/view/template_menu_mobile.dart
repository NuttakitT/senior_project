import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/core/template/template_mobile/view_model/template_mobile_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';

class TemplateMenuMobile extends StatefulWidget {
  final Widget content;
  const TemplateMenuMobile({super.key, required this.content});

  @override
  State<TemplateMenuMobile> createState() => _TemplateMenuMobileState();
}

class _TemplateMenuMobileState extends State<TemplateMenuMobile> {
  final IconData login = Icons.login_rounded;
  final IconData logout = Icons.logout_rounded;
  final String loginText = 'Login';
  final String logoutText = 'Logout';
  final double textBreakPoint = 250;

  BoxDecoration selectedStyle() {
    return const BoxDecoration(
        color: ColorConstant.orange5,
        border:
            Border(left: BorderSide(width: 3, color: ColorConstant.orange60)));
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = context.watch<AppViewModel>().isLogin;
    bool homeState = context.watch<TemplateMobileViewModel>().getMenuState(0);
    bool helpDeskState =
        context.watch<TemplateMobileViewModel>().getMenuState(1);
    bool roomState = context.watch<TemplateMobileViewModel>().getMenuState(2);
    bool profileState =
        context.watch<TemplateMobileViewModel>().getMenuState(3);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstant.white),
        centerTitle: true,
        title: Image.asset('assets/images/icon.png'),
        backgroundColor: ColorConstant.whiteBlack90,
        toolbarHeight: 90,
      ),
      backgroundColor: Colors.white,
      body: widget.content,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, right: 16, bottom: 24),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: const Icon(
                          Icons.cancel_rounded,
                          color: ColorConstant.whiteBlack80,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Container(
                        decoration: homeState ? selectedStyle() : null,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16, left: 16, right: 8),
                              child: Icon(
                                Icons.home_rounded,
                                color: homeState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: homeState
                                      ? ColorConstant.orange60
                                      : ColorConstant.whiteBlack80),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        context
                            .read<TemplateMobileViewModel>()
                            .changeMenuState(0);
                        Navigator.pushAndRemoveUntil(
                          context, 
                          MaterialPageRoute(builder: (context) {
                            return const CommunityBoardView();
                          }), 
                          (route) => false
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Container(
                        decoration: helpDeskState ? selectedStyle() : null,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16, left: 16, right: 8),
                              child: Icon(
                                Icons.table_restaurant_rounded,
                                color: helpDeskState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            ),
                            Text(
                              'HelpDesk',
                              style: TextStyle(
                                fontSize: 24,
                                color: helpDeskState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        context
                            .read<TemplateMobileViewModel>()
                            .changeMenuState(1);
                        int? role =
                            context.read<AppViewModel>().app.getUser.getRole;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HelpDeskMainView(
                                    isAdmin: role == 0 ? true : false)));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Container(
                        decoration: roomState ? selectedStyle() : null,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16, left: 16, right: 8),
                              child: Icon(
                                Icons.meeting_room_rounded,
                                color: roomState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            ),
                            Text(
                              "Teacher Contact",
                              style: TextStyle(
                                fontSize: 24,
                                color: roomState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        context
                            .read<TemplateMobileViewModel>()
                            .changeMenuState(2);
                        //TODO when click link to teacher contact
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Container(
                        decoration: profileState ? selectedStyle() : null,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, bottom: 16, left: 16, right: 8),
                              child: Icon(
                                Icons.account_circle_rounded,
                                color: profileState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            ),
                            Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 24,
                                color: profileState
                                    ? ColorConstant.orange60
                                    : ColorConstant.whiteBlack80,
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        // TODO edit profile
                        context
                            .read<TemplateMobileViewModel>()
                            .changeMenuState(3);
                        // Navigator.pushAndRemoveUntil(
                        //   context, 
                        //   MaterialPageRoute(builder: (context) {
                        //     return MyProfileView();
                        //   }), 
                        //   (route) => false
                        // );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 8),
                        child: Icon(
                          isLogin ? logout : login,
                          color: ColorConstant.whiteBlack80,
                        ),
                      ),
                      //
                      Text(
                        isLogin ? logoutText : loginText,
                        style: const TextStyle(
                            fontSize: 24, color: ColorConstant.whiteBlack80),
                      )
                    ],
                  ),
                  onTap: () async {
                    if (isLogin) {
                      await context.read<AppViewModel>().logout();
                    } else {
                      await context.read<AppViewModel>().login(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
