import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class SettingPopUp extends StatefulWidget {
  const SettingPopUp({super.key});

  @override
  State<SettingPopUp> createState() => _SettingPopUpState();
}

class _SettingPopUpState extends State<SettingPopUp> {
  // TODO add provider state
  bool isSendEmail = false;
  final TextStyle _labelStyle = const TextStyle(
      fontFamily: AppFontStyle.interFont,
      fontWeight: AppFontWeight.regular,
      fontSize: 16,
      color: ColorConstant.whiteBlack80);
  final TextStyle _descriptionStyle = const TextStyle(
      fontFamily: AppFontStyle.interFont,
      fontWeight: AppFontWeight.light,
      fontSize: 10,
      color: ColorConstant.whiteBlack60);
  final TextStyle _timeStyle = const TextStyle(
      fontFamily: AppFontStyle.interFont,
      fontWeight: AppFontWeight.regular,
      fontSize: 12,
      color: ColorConstant.whiteBlack80);
  List<String> hour = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "00"
  ];
  List<String> minute = ["00", "15", "30", "45"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: ColorConstant.orange40)),
      content: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: 328,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Notification",
                style: TextStyle(
                    fontFamily: AppFontStyle.interFont,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack80),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 24),
                child: Container(
                  width: double.infinity,
                  height: 1,
                  color: ColorConstant.whiteBlack15,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text(
                          "E-mail Notification",
                          style: _labelStyle,
                        ),
                      ),
                      Text(
                        "Send task help-desk to e-mail",
                        style: _descriptionStyle,
                      ),
                    ],
                  ),
                  // TODO add provider state
                  FlutterSwitch(
                    value: isSendEmail,
                    onToggle: (value) {
                      setState(() {
                        isSendEmail = !isSendEmail;
                      });
                    },
                    width: 32,
                    height: 16,
                    toggleSize: 12,
                    padding: 2,
                    activeColor: ColorConstant.orange40,
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 2),
                  child: Text(
                    "Time",
                    style: _labelStyle,
                  )),
              Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Set start-time and end-time for notification.",
                    style: _descriptionStyle,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 66,
                    height: 28,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstant.whiteBlack50, width: 0.5),
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${hour[7]}:${minute[0]}",
                          style: _timeStyle,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // TODO set start time
                              },
                              child: Container(
                                width: 10,
                                height: 10,
                                color: const Color(0xFFD9D9D9),
                                child: const Icon(
                                  Icons.arrow_drop_up_rounded,
                                  size: 10.5,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // TODO set stop time
                              },
                              child: Container(
                                width: 10,
                                height: 10,
                                color: const Color(0xFFD9D9D9),
                                child: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 10.5,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "To",
                      style: TextStyle(
                          fontFamily: AppFontStyle.interFont,
                          fontWeight: AppFontWeight.regular,
                          fontSize: 12,
                          color: ColorConstant.whiteBlack40),
                    ),
                  ),
                  Container(
                    width: 66,
                    height: 28,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorConstant.whiteBlack50, width: 0.5),
                        borderRadius: BorderRadius.circular(8)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${hour[15]}:${minute[0]}",
                          style: _timeStyle,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // TODO set start time
                              },
                              child: Container(
                                width: 10,
                                height: 10,
                                color: const Color(0xFFD9D9D9),
                                child: const Icon(
                                  Icons.arrow_drop_up_rounded,
                                  size: 10.5,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // TODO set stop time
                              },
                              child: Container(
                                width: 10,
                                height: 10,
                                color: const Color(0xFFD9D9D9),
                                child: const Icon(
                                  Icons.arrow_drop_down_rounded,
                                  size: 10.5,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
