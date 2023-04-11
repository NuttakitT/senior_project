import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class TotalTicket extends StatefulWidget {
  final String title;
  final int totalTickets;
  const TotalTicket(
      {super.key, required this.title, required this.totalTickets});

  @override
  State<TotalTicket> createState() => _TotalTicketState();
}

class _TotalTicketState extends State<TotalTicket> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
            height: 180,
            decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: BorderRadius.circular(8.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: AppFontStyle.blackMd18,
                  ),
                  Text(widget.totalTickets.toString(),
                      style: AppFontStyle.blackMd38),
                  Text(
                    widget.totalTickets == 1 ? "ticket" : "tickets",
                    style: AppFontStyle.wb60L14,
                  ),
                ],
              ),
            )));
  }
}
