import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/create_ticket_pop_up.dart';

class Header {
  static TextStyle titleTextStyle() => const TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w500,
      color: Color(0xFF393E42),
      fontSize: 32.0);

  static String _headerText(int type) {
    switch (type) {
      case 0:
        return "All Status";
      case 1:
        return "Not Started";
      case 2:
        return "In Progress";
      case 3:
        return "Closed";
      default:
        return "";
    }
  }

  static Widget widget(BuildContext context, bool isAdmin) {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: AppFontStyle.wb80Md32,
            child: Text(_headerText(tagBarSelected)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 1,
                color: ColorConstant.whiteBlack30,
              ),
            ),
          ),
          Builder(
            builder: (context) {
              if (!isAdmin) {
                return SizedBox(
                  width: 153,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CreateTicketPopup();
                          });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorConstant.orange50),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                        fixedSize: MaterialStateProperty.all(
                          const Size(167, 40)
                        )),
                    child: const Text(
                      "+  Create Task",
                      style: AppFontStyle.whiteSemiB16,
                    ),
                  ),
                );
              } 
              return Container();
            }
          )
        ],
      ),
    );
  }
}
