import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 4, color: ColorConstant.orange40)),
                      color: ColorConstant.orange10),
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
                    //TODO change page when click button
                    onTap: () {},
                  ),
                ),
              ),

              //TODO when select menu will have a box(Set state)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 4, color: ColorConstant.orange40)),
                      color: ColorConstant.orange10),
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
                    //TODO change page when click button
                    onTap: () {},
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 4, color: ColorConstant.orange40)),
                      color: ColorConstant.orange10),
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
                    //TODO change page when click button
                    onTap: () {},
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 4, color: ColorConstant.orange40)),
                      color: ColorConstant.orange10),
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
                    //TODO change page when click button
                    onTap: () {},
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              width: 4, color: ColorConstant.orange40)),
                      color: ColorConstant.orange10),
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
                    //TODO change page when click button
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
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
                  //TODO change page when click button
                  onTap: () {},
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
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        Icons.logout_rounded,
                        color: ColorConstant.orange70,
                      ),
                    ),
                  ),
                  //TODO change page when click button
                  onTap: () {},
                ),
              ),
            ],
          )
        ]);
  }
}
