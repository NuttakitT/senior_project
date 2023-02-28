import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class CommunityContentDesktop extends StatefulWidget {
  const CommunityContentDesktop({super.key});

  @override
  State<CommunityContentDesktop> createState() =>
      _CommunityContentMobileState();
}

class _CommunityContentMobileState extends State<CommunityContentDesktop> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 680 + (screenHeight - 957),
      // width: 680 + (screenWidth - 957),
      constraints: BoxConstraints(maxWidth: 700),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(color: ColorConstant.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // width: double.infinity,
            padding:
                const EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 4),
            decoration: const BoxDecoration(color: ColorConstant.white),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: ColorConstant.blue20,
                        borderRadius: BorderRadius.circular(24)),
                    child: const Icon(
                      Icons.face_rounded,
                      color: ColorConstant.whiteBlack80,
                      size: 20,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      //TODO pull name from back-end
                      Text(
                        "Supakorn Mahawongmekhin",
                        style: TextStyle(
                            color: ColorConstant.whiteBlack85, fontSize: 16),
                      ),
                      //TODO pull date from back-end
                      Text("Create on: 10/10/2022",
                          style: TextStyle(
                              color: ColorConstant.whiteBlack40, fontSize: 12)),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  child: const Icon(
                    Icons.edit_note_rounded,
                    color: ColorConstant.whiteBlack60,
                    size: 24,
                  ),
                  onTap: () {
                    //TODO
                  },
                )
              ],
            ),
          ),
          //TODO Tag from back-end
          Padding(
            padding: const EdgeInsets.only(left: 72),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        color: ColorConstant.whiteBlack5,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorConstant.whiteBlack20)),
                    child: const Text(
                      "FAQ",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack80, fontSize: 10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                        color: ColorConstant.whiteBlack5,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorConstant.whiteBlack20)),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: ColorConstant.whiteBlack80, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            //TODO cap text
            child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis fermentum auctor ante, sed volutpat metus porttitor non. Quisque pretium enim ac ex maximus molestie. Nunc non quam convallis, pulvinar sem in, consequat ante."),
          ),
          //TODO image
          Container(
            decoration: BoxDecoration(color: ColorConstant.red40),
            // padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
            // constraints: const BoxConstraints(maxHeight: 350),
            width: double.infinity,
            child: Image.asset(
              'lib/assets/image_demo/community_board_demo_image.jpg',
              // fit: BoxFit.cover,
              height: 200,
              width: 200,
            ),
          ),
        ],
      ),
    );
  }
}