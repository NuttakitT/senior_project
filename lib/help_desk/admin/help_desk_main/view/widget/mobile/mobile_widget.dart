import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/admin/help_desk_main/view/widget/mobile/task_card.dart';

class MobileWidget extends StatefulWidget {
  const MobileWidget({super.key});

  @override
  State<MobileWidget> createState() => _MobileWidgetState();
}

class _MobileWidgetState extends State<MobileWidget> {
  // TODO edit to provider
  final data = [
    {
      "id": "#123",
      "username": "Runnnnnnnnnnnnasdasdnnnnnnnnnnnn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsu n n nnnnnasdnnnnnnnnnnnnnnnnnnnasdnnnnnnm",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqscasaaa sadasdsa s ad asd sa sad sa as asd asasdasd asas asdas aaaaaaaaaaaaaaaaaaaaaaaaa.",
      "priority": 0, // 0-3 (low, medium, high, urgent)
      "status": 2, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp, aaaaa, maaaaaaaa,aaaaaaaaa,aaaaaaaaa",
      "time": DateFormat('hh:mm a').format(DateTime.now())
    },
    {
      "id": "#456",
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": 1, // 0-3 (low, medium, high, urgent)
      "status": 1, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": DateFormat('hh:mm a').format(DateTime.now())
    },
    {
      "id": "#456",
      "username": "Runn",
      "email": "runn@gmail.com",
      "taskHeader": "Lorem ipsum",
      "taskDetail": "Lorem ipsum dolor sit amet, consectetur adiwfefef cwcececqsc.",
      "priority": 1, // 0-3 (low, medium, high, urgent)
      "status": 0, // 0-2 (not start, pending, complete)
      "category": "Register, Modcom, Camp",
      "time": DateFormat('hh:mm a').format(DateTime.now())
    },
  ];
  
  ScrollController _vontraoller = ScrollController();

  Widget menu(String name, bool state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16,5),
      decoration: BoxDecoration(
        border: state 
        ? const Border(
          bottom: BorderSide(
            color: ColorConstant.orange50,
            width: 2
          )
        )
        : null
      ),
      child: Text(
        name,
        style: TextStyle(
          fontFamily: ColorConstant.font,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: state ? ColorConstant.orange50 : ColorConstant.whiteBlack60,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // TODO edit templete w/ scrollable
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 24, bottom: 36),
          alignment: Alignment.center,
          width: double.infinity,
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Help-desk List",
                  style: TextStyle(
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: ColorConstant.whiteBlack80
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    // TODO pop up setting
                  }, 
                  alignment: Alignment.centerRight,
                  color: ColorConstant.whiteBlack80,
                  icon: const Icon(
                    Icons.settings_rounded
                  )
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ColorConstant.whiteBlack15
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TODO listen to provider state
              Flexible(flex: 2, child: menu("All", true)),
              Flexible(flex: 4, child: menu("Not start", false)),
              Flexible(flex: 4, child: menu("In progress", false)),
              Flexible(flex: 3, child: menu("Closed", false)),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Scrollbar(
              controller: _vontraoller,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _vontraoller,
                child: Column(
                  children: [
                    TaskCard(detail: data[0]),
                    TaskCard(detail: data[1]),
                    TaskCard(detail: data[2]),
                    TaskCard(detail: data[2]),
                    TaskCard(detail: data[2]),
                    TaskCard(detail: data[2]),
                    TaskCard(detail: data[2]),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}