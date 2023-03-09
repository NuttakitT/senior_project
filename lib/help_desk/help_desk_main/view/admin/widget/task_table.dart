import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/header_table.dart';
import 'package:senior_project/help_desk/help_desk_main/view/admin/widget/table_detail.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

Stream? query(int type) {
  final FirebaseServices service = FirebaseServices("task");
  switch (type) {
    case 0:
      return service.listenToDocument();
    case 1:
      return service.listenToDocumentByKeyValuePair(["status"], [0]);
    case 2: 
      return service.listenToDocumentByKeyValuePair(["status"], [1]);
    case 3:
      return service.listenToDocumentByKeyValuePair(["status"], [2]);
    case 4:
      return service.listenToDocumentByKeyValuePair(["priority"], [3]);
    case 5:
      return service.listenToDocumentByKeyValuePair(["priority"], [2]);
    case 6:
      return service.listenToDocumentByKeyValuePair(["priority"], [1]);
    case 7:
      return service.listenToDocumentByKeyValuePair(["priority"], [0]);
    default:
      return null;
  }
}

class TaskTable extends StatefulWidget {
  const TaskTable({super.key});

  @override
  State<TaskTable> createState() => _TaskTableState();
}

class _TaskTableState extends State<TaskTable> {
  final _vController = ScrollController();
  Stream? _stream;

  Widget detail(Map<String, dynamic> detail) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 2, color: ColorConstant.whiteBlack5))),
      height: 80,
      child: Row(
        children: TableDetail(context: context, detail: detail).widget(),
      ),
    );
  }

  List<Widget> generateContent(List<Map<String, dynamic>> content) {
    List<Widget> list = [];
    for (int i = 0; i < content.length; i++) {
      list.add(detail(content[i]));
    }
    return list;
  }

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    context.read<HelpDeskViewModel>().cleanModel();
    _stream = query(tagBarSelected);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Column(
      children: [
        HeaderTable.widget(),
        Builder(
          builder: (context) {
            String searchText = context.watch<HelpDeskViewModel>().getSearchText;
            if (searchText.isEmpty) {
              context.read<HelpDeskViewModel>().cleanModel();
              return StreamBuilder(
                stream: _stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const LoaderStatus(text: "Error occurred");
                  } 
                  if (snapshot.connectionState == ConnectionState.active) {   
                    if (snapshot.data!.docs.isNotEmpty) {
                      return FutureBuilder(
                        future: context.read<HelpDeskViewModel>().reconstructQueryData(snapshot.data as QuerySnapshot),
                        builder: (context, futureSnapshot) {
                          if (futureSnapshot.connectionState == ConnectionState.done) {
                            List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
                            return FutureBuilder(
                              future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                              builder: (context, _) {
                                if (_.connectionState == ConnectionState.done) {
                                  return SizedBox(
                                    height: 680 + (screenHeight - 960),
                                    child: Scrollbar(
                                      controller: _vController,
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        controller: _vController,
                                        child: Column(
                                          children: generateContent(data)
                                        ),
                                      ),
                                    )
                                  );
                                }
                                return const LoaderStatus(text: "Loading...");
                              },
                            );
                          }
                          return Container();
                        },
                      );
                    } else {
                      context.read<HelpDeskViewModel>().cleanModel();
                      return const LoaderStatus(text: "No task in this scction");
                    }      
                  } else {
                    return const LoaderStatus(text: "Loading...");
                  }
                },
              );
            }
            context.read<HelpDeskViewModel>().getHitsSearcher.query(searchText);
            return StreamBuilder(
              stream: context.watch<HelpDeskViewModel>().getHitsSearcher.responses,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const LoaderStatus(text: "Error occurred");
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  List hits = snapshot.data!.hits.toList();
                  if (hits.isNotEmpty) {
                    List<String> docs = [];
                    for (var item in hits) {
                      if (!docs.contains(item["docId"])) {
                        docs.add(item["docId"]);
                      }
                    }
                    context.read<HelpDeskViewModel>().cleanModel();
                    return FutureBuilder(
                      future: context.watch<HelpDeskViewModel>().reconstructSearchResult(docs),
                      builder: ((context, snapshot) {
                        List<Map<String, dynamic>> data = context.watch<HelpDeskViewModel>().getTask;
                        return FutureBuilder(
                          future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                          builder: (context, _) {
                            if (_.connectionState == ConnectionState.done) {
                              return SizedBox(
                                height: 680 + (screenHeight - 960),
                                child: Scrollbar(
                                  controller: _vController,
                                  thumbVisibility: true,
                                  child: SingleChildScrollView(
                                    controller: _vController,
                                    child: Column(
                                      children: generateContent(data)
                                    ),
                                  ),
                                )
                              );
                            }
                            return const LoaderStatus(text: "Loading...");
                          },
                        );
                      }),
                    );
                  }
                  return const LoaderStatus(text: "No result");
                }
                return const LoaderStatus(text: "Loading...");
              },
            );
          },
        )
      ],
    );
  }
}
