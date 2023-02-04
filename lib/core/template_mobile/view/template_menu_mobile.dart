import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TemplateMenuMobile extends StatefulWidget {
  final Widget content;
  const TemplateMenuMobile({super.key, required this.content});

  @override
  State<TemplateMenuMobile> createState() => _TemplateMenuMobileState();
}

//TODO set color when menu = page ex. home = homepage
class _TemplateMenuMobileState extends State<TemplateMenuMobile> {
  final IconData login = Icons.login_rounded;
  final IconData logout = Icons.logout_rounded;
  final String login_text = 'Login';
  final String logout_text = 'Logout';
  final double text_base_point = 250;

  @override
  Widget build(BuildContext context) {
    final double screen_width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ColorConstant.whiteBlack80),
        title: RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: "Help ",
              style: TextStyle(
                  color: ColorConstant.blue90,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text: "Desk",
              style: TextStyle(
                  color: ColorConstant.orange90,
                  fontSize: 28,
                  fontWeight: FontWeight.bold))
        ])),
        backgroundColor: ColorConstant.white,
        toolbarHeight: 90,
      ),
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
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 8),
                            child: Icon(
                              Icons.home_rounded,
                              color: ColorConstant.whiteBlack80,
                            ),
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                                fontSize: 24,
                                color: ColorConstant.whiteBlack80),
                          )
                        ],
                      ),
                      onTap: () {
                        //TODO when click link to home page
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 8),
                            child: Icon(
                              Icons.table_restaurant_rounded,
                              color: ColorConstant.whiteBlack80,
                            ),
                          ),
                          Text(
                            'HelpDesk',
                            style: TextStyle(
                                fontSize: 24,
                                color: ColorConstant.whiteBlack80),
                          )
                        ],
                      ),
                      onTap: () {
                        //TODO when click link to helpdesk page
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 8),
                            child: Icon(
                              Icons.meeting_room_rounded,
                              color: ColorConstant.whiteBlack80,
                            ),
                          ),
                          Text(
                            (screen_width <= text_base_point)
                                ? 'Room \nReservation'
                                : 'Room Reservation',
                            style: const TextStyle(
                                fontSize: 24,
                                color: ColorConstant.whiteBlack80),
                          )
                        ],
                      ),
                      onTap: () {
                        //TODO when click link to room reservation page
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 16, bottom: 16, left: 16, right: 8),
                            child: Icon(
                              Icons.account_circle_rounded,
                              color: ColorConstant.whiteBlack80,
                            ),
                          ),
                          Text(
                            'My Profile',
                            style: TextStyle(
                                fontSize: 24,
                                color: ColorConstant.whiteBlack80),
                          )
                        ],
                      ),
                      onTap: () {
                        //TODO when click link to My profile page
                      },
                    ),
                  ),
                ],
              ),
              //TODO set state login to logout
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 16, right: 8),
                        child: Icon(
                          login,
                          color: ColorConstant.whiteBlack80,
                        ),
                      ),
                      //
                      Text(
                        login_text,
                        style: const TextStyle(
                            fontSize: 24, color: ColorConstant.whiteBlack80),
                      )
                    ],
                  ),
                  onTap: () {
                    //TODO when click link to login/logout page
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
