import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/view/desktop/page/template_community_board.dart';
import 'package:senior_project/community_board/view/mobile/page/template_community_board_mobile.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template/template_mobile/view_model/template_mobile_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class CommunityBoardView extends StatefulWidget {
  const CommunityBoardView({super.key});

  @override
  State<CommunityBoardView> createState() => _CommunityBoardViewState();
}

class _CommunityBoardViewState extends State<CommunityBoardView> {
  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
  @override
  Widget build(BuildContext context) {
    // bool isMobileSite = MediaQuery.of(context).size.width <= 430;
    return FutureBuilder(
      future: FirebaseServices("category").getDocumnetByKeyValuePair(
          ["isCommunity", "isApproved"], [true, true]),
      builder: (context, snapshot) {
        context.read<CommunityBoardViewModel>().clearAllTopic();
        if (snapshot.connectionState == ConnectionState.done) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            context
                .read<CommunityBoardViewModel>()
                .addAllTopic(snapshot.data!.docs[i].get("name"));
          }
          if (isMobileSite) {
            context.read<TemplateMobileViewModel>().changeMenuState(0);
            context.read<TextSearch>().clearSearchText();
            return const TemplateCommunityBoardMobile();
          }
          context.read<TemplateDesktopViewModel>().changeState(context, 0, 1);
          context.read<TextSearch>().clearSearchText();
          return const TemplateCommunityBoard();
        }
        return Container();
      },
    );
  }
}
