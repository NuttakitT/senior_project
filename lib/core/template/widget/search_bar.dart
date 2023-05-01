import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class SearchBar extends StatefulWidget {
  final bool isHelpDeskPage;
  const SearchBar({super.key, required this.isHelpDeskPage});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String text = "";
  bool isEditingText = false;
  FocusNode focus = FocusNode();
  int milisec = 200;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    focus.addListener(() {
      setState(() {
        isEditingText = focus.hasFocus;
      });
    });
    controller.text = context.read<TextSearch>().getSearchText;
    controller.addListener(() {
      context.read<TextSearch>().setSearchText(controller.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    focus.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // AnimatedContainer(
        //   duration: Duration(milliseconds: milisec),
        //   width: !isEditingText ? 20 : 0,
        //   child: AnimatedOpacity(
        //     opacity: !isEditingText ? 1.0 : 0.0, 
        //     duration: Duration(milliseconds: milisec),
        //     child: const Padding(
        //       padding: EdgeInsets.only(left: 16),
        //       child: Icon(
        //         Icons.search_rounded,
        //         color: ColorConstant.whiteBlack30,
        //       ),
        //     )
        //   ),
        // ),
        Expanded(
          child: AnimatedPadding(
            duration: Duration(milliseconds: milisec),
            padding: EdgeInsets.only(left: isEditingText ? 0 : 16),
            child: TextField(
              controller: controller,
              focusNode: focus,
              maxLength: 512,
              decoration: const InputDecoration(
                hintText: "search...",
                hintStyle: TextStyle(
                    color: ColorConstant.whiteBlack30,
                    fontSize: 16
                ),
                counterText: "",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero,
                  borderSide: BorderSide.none,
                  gapPadding: 0
                )
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: milisec),
          width: isEditingText ? 45 : 0,
          child: AnimatedOpacity(
            opacity: isEditingText ? 1.0 : 0.0, 
            duration: Duration(milliseconds: milisec * 2),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  
                }, 
                child: const Icon(
                  Icons.search_rounded,
                  color: ColorConstant.whiteBlack85,
                ),
              ),
            )
          ),
        ),
      ],
    );
  }
}