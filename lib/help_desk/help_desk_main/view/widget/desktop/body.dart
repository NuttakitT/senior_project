import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/desktop/content.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_reply/view/widget/desktop/body_reply_desktop.dart';

Stream? query(String id, int type, bool isAdmin) {
  final FirebaseServices service = FirebaseServices("ticket");
 if (isAdmin) {
    switch (type) {
      case 0:
        return service.listenToDocumentByKeyValuePair(["adminId"], [id]);
      case 1:
        return service.listenToDocumentByKeyValuePair(["adminId", "status"], [id, 0]);
      case 2: 
        return service.listenToDocumentByKeyValuePair(["adminId", "status"], [id, 1]);
      case 3:
        return service.listenToDocumentByKeyValuePair(["adminId", "status"], [id, 2]);
      case 4:
        return service.listenToDocumentByKeyValuePair(["adminId", "priority"], [id, 3]);
      case 5:
        return service.listenToDocumentByKeyValuePair(["adminId", "priority"], [id, 2]);
      case 6:
        return service.listenToDocumentByKeyValuePair(["adminId", "priority"], [id, 1]);
      case 7:
        return service.listenToDocumentByKeyValuePair(["adminId", "priority"], [id, 0]);
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

class Body extends StatefulWidget {
  final bool isAdmin;
  const Body({super.key, required this.isAdmin});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double contentSize = 56;
  Stream? _stream;
  ScrollController controller = ScrollController();
  static List<String> priority = ["Low", "Medium", "High", "Urgent"];
  static List<String> status = ["Not Start", "Pending", "Complete"];
  static List<String> admin = ["Admin1", "Admin2", "Admin3"];
  String priorityValue = priority[0];
  String stausValue = status[0];
  String adminValue = admin[0];

  List<Map<String, dynamic>> details = [
    {
      // "id": "",
      // "docId": "",
      "title": "test",
      "detail": "asdfghj",
      "status": 1,
      "priority": 0,
      "ownerName": "TEST TEST",
      "time": DateTime.now()
    },
    {
      "title": "test",
      "detail": "asdfghj",
      "status": 2,
      "priority": 2,
      "ownerName": "TEST TEST",
      "time": DateTime.now()
    }
  ];

  Widget _iconLoader(bool isFirst) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            // TODO go back
          }, 
          icon: const Icon(Icons.keyboard_arrow_left_rounded)
        ),
        IconButton(
          onPressed: () {
            // TODO go back
          }, 
          icon: const Icon(Icons.keyboard_double_arrow_left_rounded)
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "1-5 of 5",
            style: TextStyle(
              fontFamily: AppFontStyle.font,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ColorConstant.whiteBlack70
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO load more
          }, 
          icon: const Icon(Icons.keyboard_arrow_right_rounded)
        ),
        IconButton(
          onPressed: () {
            // TODO load more
          }, 
          icon: const Icon(Icons.keyboard_double_arrow_right_rounded)
        )
      ],
    );
  }
  List<Widget> _generateContent(List<Map<String, dynamic>> details) {
    List<Widget> list = [];
    for (int i = 0; i < details.length; i++) {
      list.add(Content(size: contentSize, detail: details[i]));
    }
    return list;
  }

  @override
  void didChangeDependencies() {
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    String id = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    context.read<HelpDeskViewModel>().cleanModel();
    _stream = query(id, tagBarSelected, isAdmin);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isShowMesg = context.watch<HelpDeskViewModel>().getIsShowMessagePage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 73,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: ColorConstant.whiteBlack40)
                  )
                ),
              ),
              Container(
                height: 72,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(left: 10, right: 16),
                alignment: AlignmentDirectional.center,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: IconButton(
                        onPressed: () {
                          // TODO refresh
                          if (isShowMesg) {
                            context.read<HelpDeskViewModel>().setShowMessagePageState(false);
                          }
                        },
                        icon: Icon(
                          isShowMesg 
                          ?  Icons.arrow_back_rounded
                          : Icons.refresh_rounded, 
                          color: ColorConstant.whiteBlack70,
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        if (isShowMesg && widget.isAdmin) {
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: ColorConstant.whiteBlack30)
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: priorityValue,
                                      style: const TextStyle(
                                        fontFamily: AppFontStyle.font,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: ColorConstant.whiteBlack90
                                      ),
                                      items:
                                          priority.map<DropdownMenuItem<String>>((value) {
                                        return DropdownMenuItem(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          priorityValue = value!;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Container(
                                  height: 32,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: ColorConstant.whiteBlack30)
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: stausValue,
                                      style: const TextStyle(
                                        fontFamily: AppFontStyle.font,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: ColorConstant.whiteBlack90
                                      ),
                                      items:
                                          status.map<DropdownMenuItem<String>>((value) {
                                        return DropdownMenuItem(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          stausValue = value!;
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: ColorConstant.whiteBlack30)
                                ),
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    value: adminValue,
                                    style: const TextStyle(
                                      fontFamily: AppFontStyle.font,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: ColorConstant.whiteBlack90
                                    ),
                                    items:
                                        admin.map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        adminValue = value!;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }
                    ),
                    const Spacer(),
                    _iconLoader(false)
                  ],
                ),
              ),
            ]
          ),
          Builder(
            builder: (context) {
              if (isShowMesg) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: screenHeight < 500 ? 500 : screenHeight - 300
                  ),
                  child: Scrollbar(
                    controller: controller,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: controller,
                      scrollDirection: Axis.vertical,
                      child: const BodyReplyDesktop()
                    ),
                  )
                );
              }
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight < 500 ? 500 : screenHeight - 376
                ),
                child: Scrollbar(
                  controller: controller,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.vertical,
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
                                  return FutureBuilder(
                                    future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                                    builder: (context, _) {
                                      if (_.connectionState == ConnectionState.done) {
                                        return Column(
                                          children: _generateContent(content)
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
                            return const LoaderStatus(text: "No task in this section");
                          }      
                        } else {
                          return const LoaderStatus(text: "Loading...");
                        }
                      },
                    ),
                  ),
                ),
              );
            }
          ),
          Builder(
            builder: (context) {
              if (!isShowMesg) {
                return Container(
                  height: 56,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _iconLoader(false),
                    ],
                  )
                );
              }
              return Container();
            }
          )
        ],
      )
    );
  }
}