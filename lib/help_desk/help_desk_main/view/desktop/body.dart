// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/admin_ticket_setting.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/ticket_list.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/body_reply_desktop.dart';
import 'package:senior_project/help_desk/help_desk_reply/view_model/reply_channel_view_model.dart';

Stream? query(String id, int type, bool isAdmin, {
  DocumentSnapshot? startDoc,
  bool isReverse = false,
  int? limit
}) {
  final FirebaseServices service = FirebaseServices("ticket");
  bool descending = true;
  if (type == 0) {
    return service.listenToDocumentByKeyValuePair(
      [isAdmin ? "adminId" : "ownerId"], 
      [id],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      startDoc: startDoc,
      isReverse: isReverse
    );
  } 
  if (type > 3){
    return service.listenToDocumentByKeyValuePair(
      [isAdmin ? "adminId" : "ownerId", "priority"], 
      [id, (type-7).abs()],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      startDoc: startDoc,
      isReverse: isReverse
    );
  }
  return service.listenToDocumentByKeyValuePair(
    [isAdmin ? "adminId" : "ownerId", "status"], 
    [id, type-1],
    limit: limit, orderingField: 'dateCreate', descending: descending,
    startDoc: startDoc,
    isReverse: isReverse
  );
}

class Body extends StatefulWidget {
  final bool isAdmin;
  const Body({super.key, required this.isAdmin});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double contentSize = 56;
  ScrollController controller = ScrollController();
  int limit = 5;

  void nextTicket(bool isNext) {
    if (isNext) {
      context.read<HelpDeskViewModel>().setSelectedTicket = context.read<HelpDeskViewModel>().getSelectedTicket! + 1;
    } else {
      context.read<HelpDeskViewModel>().setSelectedTicket = context.read<HelpDeskViewModel>().getSelectedTicket! - 1;
    }
    Map<String, dynamic> ticket = context.read<HelpDeskViewModel>().getTask[context.read<HelpDeskViewModel>().getSelectedTicket! - 1];
    context.read<ReplyChannelViewModel>().setTaskData = {
      "docId": ticket["docId"],
      "id": ticket["id"],
      "title": ticket["title"],
      "detail": ticket["detail"],
      "priority": ticket["priority"],
      "status": ticket["status"],
      "category": ticket["category"],
      "time": ticket["time"]
    };
  }

  Widget _iconLoader(bool isShowMessagePage, int start, int end, int all, int limit) {
    String srearchText = context.watch<HelpDeskViewModel>().getSearchText;
    int? msgIndex;

    if (isShowMessagePage) {
      msgIndex = context.watch<HelpDeskViewModel>().getSelectedTicket! + start - 1;
    }
    if (all == 0) {
      return Container();
    }
    if (srearchText.isNotEmpty) {
      return Container();
    }
    return Row(
      children: [
        Builder(
          builder: (context) {
            if ((!isShowMessagePage && start != 1) || (isShowMessagePage && msgIndex != 1)) {
              return IconButton(
                onPressed: () {
                  if (isShowMessagePage) {
                    if (msgIndex! <= all && msgIndex > 1) {
                      nextTicket(false);
                    }
                  } else {
                    context.read<HelpDeskViewModel>().setLoader(false, limit);
                    context.read<HelpDeskViewModel>().setPageNumber = false;
                  }
                }, 
                icon: const Icon(Icons.keyboard_arrow_left_rounded)
              );
            }
            return Container();
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            isShowMessagePage 
            ? "$msgIndex of $all"
            : "$start-$end of $all",
            style: const TextStyle(
              fontFamily: AppFontStyle.font,
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ColorConstant.whiteBlack70
            ),
          ),
        ),
        Builder(
          builder: (context) {
            if ((!isShowMessagePage && end != all) || (isShowMessagePage && msgIndex != all)) {
              return IconButton(
                onPressed: () async {
                  if (isShowMessagePage) {
                    if (msgIndex! >= 1 && msgIndex < all) {
                      nextTicket(true);
                    }
                  } else {
                    context.read<HelpDeskViewModel>().setLoader(true, limit);
                    context.read<HelpDeskViewModel>().setPageNumber = true;
                  }
                }, 
                icon: const Icon(Icons.keyboard_arrow_right_rounded)
              );
            }
            return Container();
          },
        ),
      ],
    );
  }

  Widget loadingWidget(double screenHeight) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight < 500 ? 500 : screenHeight - 300
      ),
      color: Colors.white,
      alignment: Alignment.center,
      child: const LoaderStatus(text: "Loading..")
    );
  }

  Widget bodyReply(double screenHeight) {
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

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isShowMesg = context.watch<HelpDeskViewModel>().getIsShowMessagePage;
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);

    return StreamBuilder(
      stream: query(uid, tagBarSelected, isAdmin),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            context.read<HelpDeskViewModel>().initTicket(snapshot.data!.docs.length, limit);
            int start = context.watch<HelpDeskViewModel>().getStartTicket as int;
            int end = context.watch<HelpDeskViewModel>().getEndTicket as int;
            int all = context.watch<HelpDeskViewModel>().getAllTicket ?? 0;
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
                                  if (isShowMesg) {
                                    context.read<HelpDeskViewModel>().setShowMessagePageState(false);
                                  } else {
                                    context.read<HelpDeskViewModel>().clearContentController();
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
                                  return const AdminTicketSetting();
                                }
                                return Container();
                              }
                            ),
                            const Spacer(),
                            _iconLoader(isShowMesg, start, end, all, limit),
                          ],
                        ),
                      ),
                    ]
                  ),
                  Builder(
                    builder: (context) {
                      if (isShowMesg) {
                        if (context.watch<HelpDeskViewModel>().getSelectedTicket! >= context.read<HelpDeskViewModel>().getTask.length) {
                          return StreamBuilder(
                            stream: query(
                                uid, 
                                tagBarSelected, 
                                isAdmin, 
                                startDoc: context.watch<HelpDeskViewModel>().getLastDoc,
                                limit: limit
                              ),
                            builder: (context, streamSnapshot) {
                              if (streamSnapshot.connectionState == ConnectionState.active) {
                                if (streamSnapshot.data!.docs.isNotEmpty) {
                                  context.read<HelpDeskViewModel>().setFirstDoc(streamSnapshot.data.docs.first);
                                  context.read<HelpDeskViewModel>().setLastDoc(streamSnapshot.data.docs.last);
                                  // if (context.watch<HelpDeskViewModel>().getSelectedTicket! % limit == 1) {
                                  //   context.read<HelpDeskViewModel>().setPageNumber = true;
                                  // }
                                  return FutureBuilder(
                                    future: context.read<HelpDeskViewModel>().reconstructQueryData(streamSnapshot.data as QuerySnapshot),
                                    builder: (context, futureSnapshot) {
                                      if (futureSnapshot.connectionState == ConnectionState.done) {
                                        return FutureBuilder(
                                          future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                                          builder: (context, _) {
                                            if (_.connectionState == ConnectionState.done) {
                                              return bodyReply(screenHeight);
                                            }
                                            return loadingWidget(screenHeight);
                                          },
                                        );
                                      }
                                      return loadingWidget(screenHeight);
                                    },
                                  );
                                }
                                return bodyReply(screenHeight);
                              }
                              return loadingWidget(screenHeight);
                            },
                          );
                        }
                        return bodyReply(screenHeight);
                      }
                      return TicketList(limit: limit,);
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
                              _iconLoader(isShowMesg, start, end, all, limit),
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
        return Container();
      },
    );
  }
}