import 'package:flutter/material.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar_helpdesk.dart';
import 'package:senior_project/assets/color_constant.dart';

//call function from tabtag_help.dart
class TagBarHelp extends StatefulWidget {
  const TagBarHelp({super.key});
  @override
  State<TagBarHelp> createState() => _TagBarHelpState();
}

class _TagBarHelpState extends State<TagBarHelp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding in box
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: const BoxDecoration(color: ColorConstant.blue0),
        width: 328,
        height: 1080,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, right: 24, left: 24, bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          width: 1, color: ColorConstant.whiteBlack30)),
                  height: 40,
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 4, left: 16),
                        child: Icon(
                          Icons.search_rounded,
                          color: ColorConstant.whiteBlack30,
                        ),
                      ),
                      Text(
                        "Search...",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack30, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                //TODO Search text
                print("searcher");
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "All status"),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Not Start"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "In Progress"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBarHelpDesk(name: "Closed"),
            )
          ],
        ),
      ),
    );
  }
}
