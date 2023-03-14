import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/mobile/create_task.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/mobile/setting_pop_up.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/mobile/task_card.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

Stream? query(String id, int type) {
  final FirebaseServices service = FirebaseServices("task");
 if (id.isEmpty) {
    switch (type) {
      case 0:
        return service.listenToDocument();
      case 1:
        return service.listenToDocumentByKeyValuePair(["status"], [0]);
      case 2: 
        return service.listenToDocumentByKeyValuePair(["status"], [1]);
      case 3:
        return service.listenToDocumentByKeyValuePair(["status"], [2]);
      default:
        return null;
    }
  } else {
    switch (type) {
      case 0:
        return service.listenToDocumentByKeyValuePair(["ownerId"], [id]);
      case 1:
        return service.listenToDocumentByKeyValuePair(["ownerId", "status"], [id, 0]);
      case 2:
        return service.listenToDocumentByKeyValuePair(["ownerId", "status"], [id, 1]);
      case 3:
        return service.listenToDocumentByKeyValuePair(["ownerId", "status"], [id, 2]);
      default:
        return null;
    }
  }
}

class MobileWidget extends StatefulWidget {
  final bool isAdmin;
  const MobileWidget({super.key, required this.isAdmin});

  @override
  State<MobileWidget> createState() => _MobileWidgetState();
}

class _MobileWidgetState extends State<MobileWidget> {
  final ScrollController _vContraoller = ScrollController();
  final ScrollController _menuController = ScrollController();
  int menuSelected = 0;
  Stream? _stream;

  Widget menu(String name, bool state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: state
              ? const Border(
                  bottom: BorderSide(color: ColorConstant.orange50, width: 2))
              : null),
      child: Text(
        name,
        style: state ? AppFontStyle.orange50R16 : AppFontStyle.wb60R16,
      ),
    );
  }

  double _scaleText(double pixelWidth) {
    if (pixelWidth <= 300 && pixelWidth > 250) {
      return -4;
    }
    if (pixelWidth <= 250) {
      return -6;
    }
    return 0;
  }

  List<Widget> generateContent(List<Map<String, dynamic>> content) {
    List<Widget> list = [];
    for (int i = 0; i < content.length; i++) {
      list.add(TaskCard(detail: content[i]));
    }
    return list;
  }

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<HelpDeskViewModel>().getSelectedMobileMenu();
    String id = context.watch<AppViewModel>().app.getUser.getId;
    context.read<HelpDeskViewModel>().cleanModel();
    _stream = query(widget.isAdmin ? "" : id, tagBarSelected);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double pixelWidth = MediaQuery.of(context).size.width;

    return Stack(alignment: AlignmentDirectional.bottomEnd, children: [
      Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                top: 24 + _scaleText(pixelWidth),
                bottom: 30 + _scaleText(pixelWidth)),
            alignment: Alignment.center,
            width: double.infinity,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(pixelWidth < 260 ? 10 : 0),
                  child: Align(
                    alignment: pixelWidth < 260
                        ? AlignmentDirectional.centerStart
                        : AlignmentDirectional.center,
                    child: Text(
                      "Help-desk List",
                      style: TextStyle(
                          fontFamily: AppFontStyle.font,
                          fontWeight: FontWeight.w500,
                          fontSize: 28 + _scaleText(pixelWidth),
                          color: ColorConstant.whiteBlack80),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (widget.isAdmin) {
                    return Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const SettingPopUp();
                                });
                          },
                          padding: EdgeInsets.only(
                              right: 18.25 + _scaleText(pixelWidth)),
                          iconSize: 28 + _scaleText(pixelWidth),
                          // alignment: Alignment.centerRight,
                          color: ColorConstant.whiteBlack80,
                          icon: const Icon(Icons.settings_outlined)),
                    );
                  }
                  return Container();
                })
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: ColorConstant.whiteBlack15
                  )
                )
              ),
              child: Builder(
                builder: (context) {
                  if (pixelWidth <= 340) {
                    return Scrollbar(
                      controller: _menuController,
                      thumbVisibility: true,
                      thickness: 4,
                      child: SingleChildScrollView(
                        controller: _menuController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  context.read<HelpDeskViewModel>().changeMobileMenuState(0);
                                },
                                child: menu(
                                  "All", 
                                  context.watch<HelpDeskViewModel>().getMobileMenuState(0) as bool
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  context.read<HelpDeskViewModel>().changeMobileMenuState(1);
                                },
                                child: menu(
                                  "Not start", 
                                  context.watch<HelpDeskViewModel>().getMobileMenuState(1) as bool
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  context.read<HelpDeskViewModel>().changeMobileMenuState(2);
                                },
                                child: menu(
                                  "In progress", 
                                  context.watch<HelpDeskViewModel>().getMobileMenuState(2) as bool
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                  context.read<HelpDeskViewModel>().changeMobileMenuState(3);
                                },
                              child: menu(
                                "Closed", 
                                context.watch<HelpDeskViewModel>().getMobileMenuState(3) as bool
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<HelpDeskViewModel>().changeMobileMenuState(0);
                        },
                        child: menu("All", context.watch<HelpDeskViewModel>().getMobileMenuState(0) as bool)
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HelpDeskViewModel>().changeMobileMenuState(1);
                        },
                        child: menu("Not start", context.watch<HelpDeskViewModel>().getMobileMenuState(1) as bool)
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HelpDeskViewModel>().changeMobileMenuState(2);
                        },
                        child: menu("In progress", context.watch<HelpDeskViewModel>().getMobileMenuState(2) as bool)
                      ),
                      InkWell(
                        onTap: () {
                          context.read<HelpDeskViewModel>().changeMobileMenuState(3);
                        },
                        child: menu("Closed", context.watch<HelpDeskViewModel>().getMobileMenuState(3) as bool)
                      ),
                    ],
                  );
                }
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Scrollbar(
                  controller: _vContraoller,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _vContraoller,
                    child: StreamBuilder(
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
                                  List<Map<String, dynamic>> content = context.watch<HelpDeskViewModel>().getTask;
                                  return Column(
                                  children: generateContent(content)
                                );
                                }
                                return Container();
                              },
                            );
                          } else {
                            context.read<HelpDeskViewModel>().cleanModel();
                            return const LoaderStatus(text: "No task in this section");
                          }      
                        } else {
                          return const LoaderStatus(text: "Loading...");
                        }
                      },
                    )
                  ),
                ),
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24, bottom: 74),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) {
                    return CreateTask(isAdmin: widget.isAdmin);
                  }
                )
              );
            },
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                color: ColorConstant.orange60,
                shape: BoxShape.circle
              ),
              alignment: AlignmentDirectional.center,
              child: const Icon(Icons.add, color: Colors.white, size: 32,),
            ),
          ),
        )
      ]
    );
  }
}
