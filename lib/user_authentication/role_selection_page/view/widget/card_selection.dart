import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/assets/card_text_style.dart';
import 'package:senior_project/user_authentication/role_selection_page/assets/text_constant.dart';
import 'package:senior_project/user_authentication/role_selection_page/view/widget/student_text_alignment.dart';
import 'package:senior_project/user_authentication/role_selection_page/view_model/role_selection_view_model.dart';

class CardSelection extends StatefulWidget {
  final bool isStudentCard;
  final bool isMobileSite;
  const CardSelection({
    super.key, 
    required this.isStudentCard,
    required this.isMobileSite,
  });

  @override
  State<CardSelection> createState() => _CardSelectionState();
}

class _CardSelectionState extends State<CardSelection> {  

  @override
  Widget build(BuildContext context) {
    bool isStudentCardSelected = context.watch<RoleSelectionViewModel>().getStudentCardSelected;
    double screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        if (widget.isStudentCard && !isStudentCardSelected) {
          context.read<RoleSelectionViewModel>().changeCardSelectedState(true);
        } else if(!widget.isStudentCard && isStudentCardSelected) {
          context.read<RoleSelectionViewModel>().changeCardSelectedState(false);
        }
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 580
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorConstant.orange40,
            ),
            borderRadius: BorderRadius.circular(16),
            color: (widget.isStudentCard && isStudentCardSelected) || (!widget.isStudentCard && !isStudentCardSelected) 
              ? ColorConstant.orange5 
              : Colors.white
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorConstant.orange40,
                    width: 2
                  )
                ),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: (widget.isStudentCard && isStudentCardSelected) || (!widget.isStudentCard && !isStudentCardSelected)  
                      ? ColorConstant.orange40 
                      : Colors.white,
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
                          if (widget.isMobileSite) {
                            return StudentTextAlignment.mobileAlignment(screenWidth);
                          }
                          return StudentTextAlignment.desktopAlignment();
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Builder(
                              builder: (context) {
                                if (!widget.isMobileSite) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16),
                                    child: Text(
                                      TextConstant.teacherFeatureText[0],
                                      style: CardTextStyle.subStyle(widget.isMobileSite)
                                    ),
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SizedBox(
                                    width: screenWidth - 130,
                                    child: RichText(
                                      maxLines: null,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: TextConstant.teacherFeatureText[0],
                                            style: CardTextStyle.subStyle(widget.isMobileSite)
                                          )
                                        ]
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),                           
                            Builder(
                              builder: (context) {
                                if (!widget.isMobileSite) {
                                  return  Text(
                                    TextConstant.teacherFeatureText[1],
                                    style: CardTextStyle.subStyle(widget.isMobileSite)
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: SizedBox(
                                    width: screenWidth - 130,
                                    child: RichText(
                                      maxLines: null,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: TextConstant.teacherFeatureText[1],
                                            style: CardTextStyle.subStyle(widget.isMobileSite)
                                          )
                                        ]
                                      ),
                                    ),
                                  ),
                                );
                              },
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
      ),
    );
  }
}