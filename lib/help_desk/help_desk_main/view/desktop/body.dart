// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/template/widget/search_bar.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/admin_ticket_setting.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/reply_stream.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/set_reply.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/ticket_list.dart';
import 'package:senior_project/help_desk/help_desk_main/view/widget/loader_status.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/body_reply_desktop.dart';

Stream? query(String id, int type, bool isAdmin, {
  DocumentSnapshot? startDoc,
  bool isReverse = false,
  int? limit,
  String? category
}) {
  final FirebaseServices service = FirebaseServices("ticket");
  bool descending = true;
  if (type == 0) {
    return service.listenToDocumentByKeyValuePair(
      category == null ? [isAdmin ? "relateAdmin" : "ownerId"] : [isAdmin ? "relateAdmin" : "ownerId", "category"], 
      category == null ? [id] : [id, category],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      startDoc: startDoc,
      isReverse: isReverse
    );
  } 
  if (type > 3){
    return service.listenToDocumentByKeyValuePair(
      category == null ? [isAdmin ? "relateAdmin" : "ownerId", "priority"] : [isAdmin ? "relateAdmin" : "ownerId", "priority", "category"], 
      category == null ? [id, (type-7).abs()] : [id, (type-7).abs(), category],
      limit: limit, orderingField: 'dateCreate', descending: descending,
      startDoc: startDoc,
      isReverse: isReverse
    );
  }
  return service.listenToDocumentByKeyValuePair(
    category == null ? [isAdmin ? "relateAdmin" : "ownerId", "status"] : [isAdmin ? "relateAdmin" : "ownerId", "status", "category"], 
    category == null ? [id, type-1] : [id, type-1, category],
    limit: limit, orderingField: 'dateCreate', descending: descending,
    startDoc: startDoc,
    isReverse: isReverse
  );
}

class Body extends StatefulWidget {
  final bool isAdmin;
  final List<String> categoty;
  const Body({super.key, required this.isAdmin, required this.categoty});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  double contentSize = 56;
  int limit = 20;
  ScrollController controller = ScrollController();
  
  void nextTicket(bool ishowMesg, bool isNext) {
    if (!ishowMesg) {
      context.read<HelpDeskViewModel>().clearModel();
      context.read<HelpDeskViewModel>().setIndicator(isNext, limit);
      context.read<HelpDeskViewModel>().setIsReverse = !isNext;
      context.read<HelpDeskViewModel>().setIsSafeLoad = true;
      if (isNext) {
        context.read<HelpDeskViewModel>().setPageNumber = context.read<HelpDeskViewModel>().getPageNumber + 1;
      } else {
        context.read<HelpDeskViewModel>().setPageNumber = context.read<HelpDeskViewModel>().getPageNumber - 1;
      }
    }
    if (ishowMesg && isNext) {
      context.read<HelpDeskViewModel>().setSelectedTicket = context.read<HelpDeskViewModel>().getSelectedTicket! + 1;
    } else if (ishowMesg && !isNext) {
      context.read<HelpDeskViewModel>().setSelectedTicket = context.read<HelpDeskViewModel>().getSelectedTicket! - 1;
    } 
  }

  Widget _iconLoader(bool isShowMessagePage, int start, int end, int all, int limit) {
    String srearchText = context.watch<TextSearch>().getSearchText;
    int? msgIndex;

    if (isShowMessagePage) {
      msgIndex = context.watch<HelpDeskViewModel>().getSelectedTicket!;
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
                  if (context.read<HelpDeskViewModel>().getIsSafeClick) {
                    nextTicket(isShowMessagePage, false);
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
                onPressed: () {
                  if (context.read<HelpDeskViewModel>().getIsSafeClick) {
                    nextTicket(isShowMessagePage, true);
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

  Widget bodyReply(double screenHeight) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight < 500 ? 500 : screenHeight - 300
      ),
      padding: const EdgeInsets.only(bottom: 8),
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

  String selectedValue = "All Ticket";
  List<String> list = ["All Ticket", "Not Start", "In Progress", "Closed"];
  late String selectedCategory;
  
  @override
  void initState() {
    selectedCategory = widget.categoty.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    bool isShowMesg = context.watch<HelpDeskViewModel>().getIsShowMessagePage;
    bool isFromNoti = context.watch<HelpDeskViewModel>().getIsFromNoti;
    String uid = context.watch<AppViewModel>().app.getUser.getId;
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;
    int tagBarSelected = context.watch<TemplateDesktopViewModel>().selectedTagBar(4);
    String? categoryFilter = selectedCategory == "All category" ? null : selectedCategory;

    return Column(
      children: [
        Builder(
          builder: (context) {
            if (context.watch<HelpDeskViewModel>().getIsShowMessagePage) {
              return Container();
            }
            return Padding(
              padding: const EdgeInsets.only(left: 43, bottom: 40, right: 40),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 6),
                    child: Icon(Icons.filter_alt_rounded, size: 16, color: ColorConstant.whiteBlack60,),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "Filter",
                      style: TextStyle(
                        fontWeight: AppFontWeight.regular,
                        fontSize: 20,
                        color: ColorConstant.whiteBlack60
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorConstant.whiteBlack40),
                      color: Colors.white
                    ),
                    width: 300,
                    height: 40,
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      underline: Container(),
                      isExpanded: true,
                      value: selectedValue,
                      items: list.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e)
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                        int? status = value == "All Ticket" ? null : list.indexOf(value!)-1;
                        context.read<HelpDeskViewModel>().setIsFormNoti = false;
                        context.read<TemplateDesktopViewModel>().changeState(context, list.indexOf(selectedValue), 4);
                        context.read<HelpDeskViewModel>().setShowMessagePageState(false);
                        context.read<HelpDeskViewModel>().clearContentController();
                        context.read<HelpDeskViewModel>().clearModel();
                        context.read<HelpDeskViewModel>().clearReplyDocId();
                        context.read<HelpDeskViewModel>().setIsSafeLoad = true;
                        context.read<HelpDeskViewModel>().setSelectedStatus = status;
                      }
                    ),
                  ),
                  Builder(
                    builder: (context) {
                      if (widget.categoty.isEmpty) {
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: ColorConstant.whiteBlack40),
                            color: Colors.white
                          ),
                          width: 300,
                          height: 40,
                          alignment: Alignment.center,
                          child: 
                          DropdownButton<String>(
                            underline: Container(),
                            isExpanded: true,
                            value: selectedCategory,
                            items: widget.categoty.map((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Text(e)
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value!;
                              });
                              String? category = value == "All category" ? null : value;
                              context.read<HelpDeskViewModel>().setIsFormNoti = false;
                              context.read<TemplateDesktopViewModel>().changeState(context, list.indexOf(selectedValue), 4);
                              context.read<HelpDeskViewModel>().setShowMessagePageState(false);
                              context.read<HelpDeskViewModel>().clearContentController();
                              context.read<HelpDeskViewModel>().clearModel();
                              context.read<HelpDeskViewModel>().clearReplyDocId();
                              context.read<HelpDeskViewModel>().setIsSafeLoad = true;
                              context.read<HelpDeskViewModel>().setSelectedCategory  = category;
                            }
                          ),
                        ),
                      );
                    }
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorConstant.whiteBlack40),
                    ),
                    width: 280,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: const SearchBar(
                      isHelpDeskPage: true
                    )
                  )
                ],
              ),
            );
          }
        ),
        StreamBuilder(
          stream: query(
            uid, 
            tagBarSelected, 
            isAdmin,
            category: categoryFilter
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                int docAmount = 0;
                for (int i = 0; i < snapshot.data!.docs.length; i++) {
                  if (snapshot.data.docs[i].get("adminId") == null || snapshot.data.docs[i].get("adminId") == uid) {
                    docAmount++;
                  }
                }
                context.read<HelpDeskViewModel>().initTicket(docAmount, limit);
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
                                      if (isFromNoti) {
                                        context.read<HelpDeskViewModel>().setIsFormNoti = false;
                                      }
                                      else if (isShowMesg) {
                                        context.read<HelpDeskViewModel>().setShowMessagePageState(false);
                                        context.read<HelpDeskViewModel>().clearModel();
                                        context.read<HelpDeskViewModel>().setIsSafeClick = false;
                                        context.read<HelpDeskViewModel>().setIsSafeLoad = true;
                                      } else {
                                        context.read<HelpDeskViewModel>().clearModel();
                                        context.read<HelpDeskViewModel>().clearContentController();
                                        context.read<TextSearch>().clearSearchText();
                                      }
                                    },
                                    icon: Icon(
                                      isShowMesg || context.watch<HelpDeskViewModel>().getIsFromNoti
                                      ?  Icons.arrow_back_rounded
                                      : Icons.refresh_rounded, 
                                      color: ColorConstant.whiteBlack70,
                                    ),
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    if ((isShowMesg || isFromNoti) && widget.isAdmin) {
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
                          if (isFromNoti) {
                            return bodyReply(screenHeight);
                          }
                          if (isShowMesg) {
                            int selectedTicket = context.watch<HelpDeskViewModel>().getSelectedTicket!;
                            int calculatedPage = (selectedTicket / (limit)).ceil();
                            int pageNumber = context.read<HelpDeskViewModel>().getPageNumber;
                            context.read<HelpDeskViewModel>().addPreviousFirst = context.read<HelpDeskViewModel>().getFirstDoc!.id;
                            context.read<HelpDeskViewModel>().setIsReverse = true;
                            if (calculatedPage == pageNumber) {
                              SetReply.setReplyPageData(context, limit);
                            } 
                            if (calculatedPage > pageNumber) {
                              if (calculatedPage > pageNumber) {
                                context.read<HelpDeskViewModel>().setIndicator(true, limit);
                              } else if ((selectedTicket / (limit)).ceil() < pageNumber) {
                                context.read<HelpDeskViewModel>().setIndicator(false, limit);
                              }
                              context.read<HelpDeskViewModel>().setPageNumber = calculatedPage;
                              return ReplyStream(
                                stream: query(
                                  uid, 
                                  tagBarSelected, 
                                  isAdmin, 
                                  startDoc: context.watch<HelpDeskViewModel>().getLastDoc,
                                  limit: limit,
                                ), 
                                limit: limit,
                                body: bodyReply(screenHeight),
                                loder: loadingWidget(screenHeight),
                              );
                            } 
                            else if (calculatedPage < pageNumber) {
                              if (calculatedPage > pageNumber) {
                                context.read<HelpDeskViewModel>().setIndicator(true, limit);
                              } else if ((selectedTicket / (limit)).ceil() < pageNumber) {
                                context.read<HelpDeskViewModel>().setIndicator(false, limit);
                              }
                              context.read<HelpDeskViewModel>().setPageNumber = calculatedPage;
                              return FutureBuilder(
                                future: context.read<HelpDeskViewModel>().getPreviousFirst,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return ReplyStream(
                                      stream: query(
                                        uid, 
                                        tagBarSelected, 
                                        isAdmin, 
                                        startDoc: snapshot.data,
                                        limit: limit,
                                        isReverse: true
                                      ), 
                                      limit: limit, 
                                      body: bodyReply(screenHeight), 
                                      loder: loadingWidget(screenHeight),
                                    );
                                  }
                                  return loadingWidget(screenHeight);
                                },
                              );
                            }
                            context.read<HelpDeskViewModel>().setIsSafeClick = true;
                            return bodyReply(screenHeight);
                          }
                          return TicketList(limit: limit, selectedCategory: selectedCategory == "All category" ? null : selectedCategory,);
                        }
                      ),
                      Builder(
                        builder: (context) {
                          if (!isShowMesg && !isFromNoti) {
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
        ),
      ],
    );
  }
}