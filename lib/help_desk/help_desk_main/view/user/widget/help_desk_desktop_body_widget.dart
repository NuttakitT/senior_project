import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view/user/widget/help_desk_card_widget.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class HelpDeskDesktopBody extends StatefulWidget {
  const HelpDeskDesktopBody({super.key});

  @override
  State<HelpDeskDesktopBody> createState() => _HelpDeskDesktopBodyState();
}

class _HelpDeskDesktopBodyState extends State<HelpDeskDesktopBody> {
  List<Widget> generateContent(List<Map<String, dynamic>> data) {
    List<Widget> content = [];
    for (int i = 0; i < data.length; i++) {
      content.add(HelpDeskCardWidget(card: data[i],context: context).widget());
    }
    return content;
  }

  @override
  Widget build(BuildContext context) {
    var bodyPadding = const EdgeInsets.fromLTRB(77, 40, 20, 0);
    List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;

    return Padding(
        padding: bodyPadding,
        child: data.isNotEmpty
            ? SizedBox(
                width: double.infinity,
                child: Column(
                  children: generateContent(data),
                )
              )
            : const Center(
                child: Text(
                  "All problems solved!",
                  style: TextStyle(
                    fontFamily: ColorConstant.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: ColorConstant.whiteBlack60
                  ),
                ),
              ));
  }
}
