import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/admin_ticket_setting.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/ticket_list.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/body_reply_desktop.dart';

Stream? query(String id, int type, bool isAdmin) {
  final FirebaseServices service = FirebaseServices("ticket");
  if (type == 0) {
    return service.listenToDocumentByKeyValuePair(
      [isAdmin ? "adminId" : "ownerId"], 
      [id],
    );
  } 
  if (type > 3){
    return service.listenToDocumentByKeyValuePair(
      [isAdmin ? "adminId" : "ownerId", "priority"], 
      [id, (type-7).abs()],
    );
  }
  return service.listenToDocumentByKeyValuePair(
    [isAdmin ? "adminId" : "ownerId", "status"], 
    [id, type-1],
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

  Widget _iconLoader(bool isShowMessagePage, int start, int end, int all, int limit) {
    if (all == 0) {
      return Container();
    }
    return Row(
      children: [
        Builder(
          builder: (context) {
            if (start != 1) {
              return IconButton(
                onPressed: () {
                  // TODO go back
                }, 
                icon: const Icon(Icons.keyboard_double_arrow_left_rounded)
              );
            }
            return Container();
          },
        ),
        Builder(
          builder: (context) {
            if (start != 1) {
              return IconButton(
                onPressed: () {
                  context.read<HelpDeskViewModel>().setIsLoadMore(false, limit);
                  context.read<HelpDeskViewModel>().setIsLoadLess(true, limit);
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
            ? "${context.read<HelpDeskViewModel>().getSelectedTicket} of $all"
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
            if (end != all) {
              return IconButton(
                onPressed: () {
                  context.read<HelpDeskViewModel>().setIsLoadMore(true, limit);
                  context.read<HelpDeskViewModel>().setIsLoadLess(false, limit);
                }, 
                icon: const Icon(Icons.keyboard_arrow_right_rounded)
              );
            }
            return Container();
          },
        ),
        Builder(
          builder: (context) {
            if (end != all) {
              return IconButton(
                onPressed: () {
                  // TODO load more
                }, 
                icon: const Icon(Icons.keyboard_double_arrow_right_rounded)
              );
            }
            return Container();
          },
        ),
      ],
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