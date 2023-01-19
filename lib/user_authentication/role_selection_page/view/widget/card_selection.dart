import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/assets/card_text_style.dart';
import 'package:senior_project/user_authentication/role_selection_page/assets/text_constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/widget/student_text_alignment.dart';

class CardSelection extends StatefulWidget {
  final bool isStudentCard;
  final bool isMobileSite;
  final bool isTextBreakpoint;
  const CardSelection({
    super.key, 
    required this.isStudentCard,
    required this.isMobileSite,
    required this.isTextBreakpoint
  });

  @override
  State<CardSelection> createState() => _CardSelectionState();
}

class _CardSelectionState extends State<CardSelection> {
  // TODO change card seleted state
  bool isSelectedCard = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        // TODO change card seleted state
        setState(() {
          isSelectedCard = !isSelectedCard;
        });
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 580
        ),
        child: Container(
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
              // TODO listen state form view model
              Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constant.orange40,
                    width: 2
                  )
                ),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isSelectedCard ? Constant.orange40 : Colors.white,
                    shape: BoxShape.circle
                  ),
                ),
              ), 
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        widget.isStudentCard ? "Student" : "Teacher",
                        style: CardTextStyle.headerStyle(widget.isMobileSite),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (widget.isStudentCard) {
                          if (widget.isTextBreakpoint) {
                            return StudentTextAlignment.rowAlignmentText(screenWidth);
                          }
                          return StudentTextAlignment.desktopWidget(screenWidth);
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                TextConstant.teacherFeatureText[0],
                                style: CardTextStyle.subStyle(screenWidth)
                              ),
                            ),
                            Text(
                              widget.isMobileSite || (screenWidth <= 505 && screenWidth > 430)
                                ? TextConstant.teacherFeatureText[2]
                                : TextConstant.teacherFeatureText[1],
                              style: CardTextStyle.subStyle(screenWidth)
                            )
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
      ),
    );
  }
}