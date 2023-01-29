import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_main_view_model.dart';

class HelpDeskMainView extends StatefulWidget {
  const HelpDeskMainView({super.key});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {
  // TODO: change viewModel to Provider
  HelpDeskViewModel viewModel = HelpDeskViewModel();

  @override
  void initState() {
    super.initState();
  }

  List helpDeskCard = [
    "Oh nana",
    "Oh Asok",
    "Oh nana",
    "Oh Asok",
    "Oh nana",
    "Oh Asok",
    "Oh nana",
    "Oh Asok",
    "Oh nana",
    "Oh Asok",
    "Oh nana",
    "Oh Asok",
    "Oh nana",
    "Oh Asok",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(color: Colors.transparent),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32.0, 16.0, 12.0, 32.0),
                  child: Row(
                    children: [
                      Text('Help Desk', style: ColorConstant().blackMd38),
                      const Spacer(),
                      TextButton(
                        child: Text('+ Create Task',
                            style: ColorConstant().orange500B16),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: helpDeskCard.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 125,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Urgent!!",
                                      style: ColorConstant().orange500B16),
                                  Text("Category:",
                                      style: ColorConstant().blackL20),
                                  Text("Detail:",
                                      style: ColorConstant().blackL20)
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(helpDeskCard[index],
                                      style: ColorConstant().blackMd24),
                                  Text(helpDeskCard[index],
                                      style: ColorConstant().blackMd20),
                                  Container(
                                    width: 500, //TODO: Fix width
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: Text(helpDeskCard[index],
                                          style: ColorConstant().grey50Md16),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Time is ",
                                    style: ColorConstant().blackMd18),
                                ButtonWithText(text: "Message")
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(71, 12, 71, 12),
            child: Text(text, style: ColorConstant().white14B),
          ),
        ),
        onPressed: () {});
  }
}
