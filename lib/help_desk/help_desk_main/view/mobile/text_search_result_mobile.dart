import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';
import 'package:senior_project/help_desk/help_desk_main/view/mobile/ticket_card.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class TextSearcResultMobile extends StatefulWidget {
  const TextSearcResultMobile({super.key});

  @override
  State<TextSearcResultMobile> createState() => _TextSearcResultMobileState();
}

class _TextSearcResultMobileState extends State<TextSearcResultMobile> {
  List<Widget> generateContent(List<Map<String, dynamic>> content) {
    List<Widget> list = [];
    for (int i = 0; i < content.length; i++) {
      list.add(TicketCard(detail: content[i]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    String id = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    int menuSelected = context.watch<HelpDeskViewModel>().getSelectedMobileMenu();

    return StreamBuilder(
      stream: context.watch<TextSearch>().getHitsSearcher.responses,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const LoaderStatus(text: "Error occurred");
        }
        if (snapshot.connectionState == ConnectionState.active) {
          List hits = snapshot.data!.hits.toList();
          if (hits.isNotEmpty) {
            List<String> docs = [];
            for (var item in hits) {
              if (menuSelected == 0) {
                if (!docs.contains(item["docId"])
                && item[isAdmin ? "adminId" : "ownerId"] == id) {
                  docs.add(item["docId"]);
                }
              } else {
                if (!docs.contains(item["docId"])
                && item[isAdmin ? "adminId" : "ownerId"] == id
                && item["status"] == menuSelected-1) {
                  docs.add(item["docId"]);
                }
              }
            }
            if (docs.isEmpty) {
              return const LoaderStatus(text: "No result");
            }
            context.read<HelpDeskViewModel>().clearModel();
            return FutureBuilder(
              future: context.read<HelpDeskViewModel>().reconstructSearchResult(docs),
              builder: ((context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.done) {
                  List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
                  return FutureBuilder(
                  future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                  builder: (context, _) {
                    if (_.connectionState == ConnectionState.done) {
                      return Column(
                        children: generateContent(data)
                      );
                    }
                    return const LoaderStatus(text: "Loading...");
                  },
                );                         
                }
                return Container();
              }),
            );
          }
          return const LoaderStatus(text: "No result");
        }
        return const LoaderStatus(text: "Loading...");
      },
    );
  }
}