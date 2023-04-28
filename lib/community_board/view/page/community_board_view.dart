import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/community_board/view/desktop/page/template_community_board.dart';
import 'package:senior_project/community_board/view/mobile/page/template_community_board_mobile.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';

class CommunityBoardView extends StatefulWidget {
  const CommunityBoardView({super.key});

  @override
  State<CommunityBoardView> createState() => _CommunityBoardViewState();
}

class _CommunityBoardViewState extends State<CommunityBoardView> {
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context.watch<AppViewModel>().getMobileSiteState(MediaQuery.of(context).size.width);
    return FutureBuilder(
      future: FirebaseServices("category").getDocumnetByKeyValuePair(
        ["isCommunity", "isApproved"],
        [true, true]
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            context.read<CommunityBoardViewModel>().addAllTopic(
              snapshot.data!.docs[i].get("name")
            );
          }
          if (isMobileSite) {
            context.read<TextSearch>().clearSearchText();
            return const TemplateCommunityBoardMobile();
          }
          context.read<TextSearch>().clearSearchText();
          return const TemplateCommunityBoard();
        }
        return Container();
      },
    );
  }
}