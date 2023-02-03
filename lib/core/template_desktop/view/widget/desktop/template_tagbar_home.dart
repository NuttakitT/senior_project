import 'package:flutter/material.dart';
import 'package:senior_project/core/template_desktop/view/widget/desktop/tagbar.dart';
import 'package:senior_project/assets/color_constant.dart';

//call function from tabtag.dart
class TagBarHome extends StatefulWidget {
  const TagBarHome({super.key});
  @override
  State<TagBarHome> createState() => _TagBarHomeState();
}

class _TagBarHomeState extends State<TagBarHome> {
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
                      borderRadius: BorderRadius.circular(16)),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      "Tag Post",
                      style: TextStyle(
                          fontSize: 20,
                          color: ColorConstant.whiteBlack80,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: ColorConstant.whiteBlack20,
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(name: "All tag post"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(name: "Register"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(name: "FAQ"),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: TagBar(name: "Document"),
            )
          ],
        ),
      ),
    );
  }
}
