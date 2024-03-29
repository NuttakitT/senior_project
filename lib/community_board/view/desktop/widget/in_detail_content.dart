import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/desktop/widget/comment_field.dart';
import 'package:senior_project/community_board/view/widget/commenet_loader.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';

class InDetailContent extends StatefulWidget {
  const InDetailContent({super.key});

  @override
  State<InDetailContent> createState() => _InDetailContentState();
}

class _InDetailContentState extends State<InDetailContent> {
  TextEditingController detailController = TextEditingController();

  List<Widget> getTopic(List<dynamic> topic) {
    List<Widget> list = [];
    for (int i = 0; i < topic.length; i++) {
      list.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
              height: 40,
              width: 250,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorConstant.white,
                  border: Border.all(color: ColorConstant.whiteBlack30),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                topic[i].toString(),
                style: const TextStyle(
                    color: ColorConstant.whiteBlack70, fontSize: 18),
              )),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> info =
        context.watch<CommunityBoardViewModel>().getPostDetail;
    detailController.text = info["detail"];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: ColorConstant.whiteBlack5,
                border: Border.all(color: ColorConstant.whiteBlack40),
                borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextButton(
                      onPressed: () {
                        context
                            .read<CommunityBoardViewModel>()
                            .setIsShowPostDetail(false, false, {});
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ColorConstant.orange70),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(16))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                                fontFamily: AppFontStyle.font,
                                fontSize: 20,
                                fontWeight: AppFontWeight.medium,
                                color: Colors.white),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    info["title"],
                    style: const TextStyle(
                        color: ColorConstant.orange70,
                        fontSize: 32,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: Text(
                          info["ownerName"],
                          style: const TextStyle(
                              color: ColorConstant.whiteBlack70, fontSize: 16),
                        ),
                      ),
                      Text(
                        info["dateCreate"],
                        style: const TextStyle(
                            color: ColorConstant.whiteBlack50, fontSize: 16),
                      )
                    ],
                  ),
                ),
                Wrap(
                  runSpacing: 4,
                  children: getTopic(info["topic"]),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: TextField(
                      style: const TextStyle(fontSize: 18),
                      maxLines: null,
                      readOnly: true,
                      controller: detailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide.none,
                              gapPadding: 0)),
                    )),
                Builder(
                  builder: (context) {
                    if (info["imageUrl"] != null) {
                      return Image.network(info["imageUrl"]);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 24),
          child: CommentField(
            docId: info["docId"],
          ),
        ),
        CommentLoader(docId: info["docId"], isMobile: false)
      ],
    );
  }
}
