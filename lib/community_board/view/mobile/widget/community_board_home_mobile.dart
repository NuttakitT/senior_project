import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';

class CommunityBoardHomeMobile extends StatefulWidget {
  const CommunityBoardHomeMobile({super.key});

  @override
  State<CommunityBoardHomeMobile> createState() =>
      _CommunityBoardHomeMobileState();
}

class _CommunityBoardHomeMobileState extends State<CommunityBoardHomeMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Container(
            height: 126,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: ColorConstant.white, boxShadow: [
              BoxShadow(
                offset: const Offset(-1, 2),
                color: ColorConstant.black.withOpacity(0.10),
                blurRadius: 4,
              )
            ]),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    "Community Board",
                    style: TextStyle(
                        color: ColorConstant.whiteBlack90,
                        fontSize: 28,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 428),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 265,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          decoration: BoxDecoration(
                              color: ColorConstant.white,
                              border:
                                  Border.all(color: ColorConstant.whiteBlack40),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.search_rounded,
                                  color: ColorConstant.whiteBlack40,
                                  size: 16,
                                ),
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                    color: ColorConstant.whiteBlack40,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          bool isLogin = context.watch<AppViewModel>().isLogin;
                          if (!isLogin) {
                            return Container();
                          }
                          return TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                side: const BorderSide(
                                    color: ColorConstant.orange50, width: 1),
                                fixedSize: const Size(95, 40),
                                foregroundColor: ColorConstant.orange50,
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                backgroundColor: ColorConstant.white,
                                textStyle: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500)),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    Icons.add_photo_alternate_rounded,
                                    color: ColorConstant.orange50,
                                    size: 14,
                                  ),
                                ),
                                Text("Create Post"),
                              ],
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  color: ColorConstant.black.withOpacity(0.10),
                  blurRadius: 4,
                )
              ],
              color: ColorConstant.white,
              border: const Border(
                  top: BorderSide(color: ColorConstant.whiteBlack20, width: 1),
                  bottom:
                      BorderSide(color: ColorConstant.whiteBlack20, width: 1))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                //TODO topic
                Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Text(
                    "การลงทะเบียน",
                    style: TextStyle(
                        color: ColorConstant.orange70,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Text(
                  //TODO description topic
                  "คำถามเกี่ยวกับการลงทะเบียนเรียน",
                  style: TextStyle(
                      color: ColorConstant.whiteBlack80, fontSize: 12),
                )
              ]),
        ),
        //TODO list post
        Container(
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 8, left: 8),
          decoration: const BoxDecoration(
            color: ColorConstant.white,
            border: Border(
                bottom:
                    BorderSide(color: ColorConstant.whiteBlack20, width: 1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "ดูเพิ่มเติม",
                style: TextStyle(color: ColorConstant.orange70, fontSize: 16),
              ),
              Icon(
                Icons.expand_more_rounded,
                color: ColorConstant.orange70,
                size: 24,
              )
            ],
          ),
        ),
      ],
    );
  }
}
