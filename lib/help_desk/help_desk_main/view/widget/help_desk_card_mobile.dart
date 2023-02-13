import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/model/help_desk_main_model.dart';

class HelpDeskCardMobile {
  final HelpDeskCard card;
  const HelpDeskCardMobile({required this.card});
  static TextStyle statusTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF33C997),
      fontSize: 12.0);
  static TextStyle titleTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w600,
      color: Color(0xFF393E42),
      fontSize: 20.0);
  static TextStyle cardNumberTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6B6E71),
      fontSize: 16.0);
  static TextStyle priorityTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6B6E71),
      fontSize: 12.0);
  static TextStyle taskDetailTextStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF6B6E71),
      fontSize: 14.0);
  static TextStyle detailTitleStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w300,
      color: Color(0xFF393E42),
      fontSize: 14.0);
  static TextStyle detailDetailedStyle() => const TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: Color(0xFF393E42),
      fontSize: 14.0);

  static Widget widget(BuildContext context, {required HelpDeskCard card}) {
    final cardNumberText = "#" + card.cardNumber.toString();

    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFFF9800), width: 1.0),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // [1] Title and icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: titleTextStyle(),
                    child: Text(card.title ?? ""),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  DefaultTextStyle(
                    style: cardNumberTextStyle(),
                    child: Text(cardNumberText),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        // tap for more information
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: Color(0xFFEF6C00),
                      ))
                ],
              ),
              const SizedBox(height: 4.0),
              // [2] Status and priority
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF33C997), width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xFFCCF1E5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
                      child: DefaultTextStyle(
                        style: statusTextStyle(),
                        child: const Text("Complete"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFDADBDC), width: 1.0),
                        borderRadius: BorderRadius.circular(8.0),
                        color: const Color(0xFFE6E7E7)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 2.0, right: 8.0, bottom: 2.0),
                      child: DefaultTextStyle(
                        style: priorityTextStyle(),
                        child: Text(card.priority ?? ""),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              // [3] Sender name and time
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 86,
                          child: DefaultTextStyle(
                            style: detailTitleStyle(),
                            child: const Text("Sender name:",
                                textAlign: TextAlign.end),
                          ),
                        ),
                        const SizedBox(width: 24),
                        DefaultTextStyle(
                          style: detailDetailedStyle(),
                          child: Text(
                            card.userName ?? "Anonymous",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DefaultTextStyle(
                      style: detailTitleStyle(),
                      child: const Text("Time:"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DefaultTextStyle(
                      style: detailDetailedStyle(),
                      child: const Text("12.34.56"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // [4] Category
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DefaultTextStyle(
                      style: detailTitleStyle(),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 86,
                            child: DefaultTextStyle(
                              style: detailTitleStyle(),
                              child: const Text("Category:",
                                  textAlign: TextAlign.end),
                            ),
                          ),
                          const SizedBox(width: 24),
                          DefaultTextStyle(
                            style: detailDetailedStyle(),
                            child: Text(card.category ?? "",
                                textAlign: TextAlign.start),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              // [5] Detail
              Row(
                children: [
                  DefaultTextStyle(
                    style: detailTitleStyle(),
                    child: const Text("Detail"),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              // [6] Detailed Box
              Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xFFDADBDC), width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: DefaultTextStyle(
                      style: taskDetailTextStyle(),
                      child: Text(card.detail ?? "")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
