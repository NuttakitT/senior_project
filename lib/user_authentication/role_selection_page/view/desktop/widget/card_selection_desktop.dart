import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/desktop/widget/selection_idicator.dart';

class CardSelectionDesktop extends StatefulWidget {
  final bool isStudentCard;
  const CardSelectionDesktop({super.key, required this.isStudentCard});

  @override
  State<CardSelectionDesktop> createState() => _CardSelectionDesktopState();
}

class _CardSelectionDesktopState extends State<CardSelectionDesktop> {
  // TODO change card seleted state
  bool isSelectedCard = false;

  TextStyle headerStyle = const TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w500,
    fontSize: 24,
    color: Constant.whiteBlack80
  );

  TextStyle subStyle = const TextStyle(
    fontFamily: Constant.font,
    fontWeight: FontWeight.w300,
    fontSize: 18,
    color: Constant.whiteBlack90
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // TODO change card seleted state
        setState(() {
          isSelectedCard = !isSelectedCard;
        });
      },
      child: Container(
        width: 580,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(
            color: Constant.orange40,
          ),
          borderRadius: BorderRadius.circular(16),
          color: isSelectedCard ? Constant.orange5 : Colors.white
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectionIdicator(isSelected: isSelectedCard), // TODO listen state form view model
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      widget.isStudentCard ? "Student" : "Teacher",
                      style: headerStyle,
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (widget.isStudentCard) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      "\u00b7 Send help-desk task to admin.",
                                      style: subStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      "\u00b7 Frequently Ask Questions",
                                      style: subStyle,
                                    ),
                                  ),
                                  Text(
                                    "\u00b7 Contact teacher with social media.",
                                    style: subStyle,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    "\u00b7 Community Board.",
                                    style: subStyle,
                                  ),
                                ),
                                Text(
                                  "\u00b7 Booking CPE rooms.",
                                  style: subStyle,
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Text(
                              "\u00b7 All Features like a role “Student”.",
                              style: subStyle,
                            ),
                          ),
                          Text(
                            "\u00b7 Can link your profile with “Contact Card” for update card.",
                            style: subStyle,
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}