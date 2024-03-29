import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/community_board/view/page/community_board_view.dart';
import 'package:senior_project/community_board/view_model/community_board_view_model.dart';
import 'package:senior_project/core/template/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/core/view_model/text_search.dart';
import 'package:senior_project/facility/view/admin_room/admin_room.dart';
import 'package:senior_project/facility/view/item_reservation/item_reservation.dart';
import 'package:senior_project/facility/view/my_booking/my_booking.dart';
import 'package:senior_project/facility/view/room_reservation/room_reservation_view.dart';
import 'package:senior_project/facility/view/schedule/schedule_room.dart';
import 'package:senior_project/help_desk/help_desk_main/view/page/help_desk_main_view.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';
import 'package:senior_project/role_management/view/role_management_view.dart';
import 'package:senior_project/statistic/view/statistic_view.dart';
import 'package:senior_project/teacher_contact/view/teacher_contact_view.dart';

class TagBar extends StatefulWidget {
  final String name;
  final int index;
  final int type;
  const TagBar(
      {super.key,
      required this.name,
      required this.index,
      required this.type});

  @override
  State<TagBar> createState() => _TagBarState();
}

class _TagBarState extends State<TagBar> {
  @override
  Widget build(BuildContext context) {
    // bool state = context.watch<TemplateDesktopViewModel>().getHomeState(widget.index);
    bool state = context.watch<TemplateDesktopViewModel>().getNavBarState(widget.index);
    bool isAdmin = context.watch<AppViewModel>().app.getUser.getRole == 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: state == true
                  ? ColorConstant.orange80
                  : ColorConstant.whiteBlack85,
              borderRadius: BorderRadius.circular(8)),
          height: 40,
          width: 280,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontFamily: AppFontStyle.font,
                    fontWeight: AppFontWeight.regular,
                    color: ColorConstant.white,
                    fontSize: 20),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // bool isApprovedPage = context.read<TemplateDesktopViewModel>().getIsApprovedPage;
          // if (!isApprovedPage && context.read<CommunityBoardViewModel>().getIsSafeClick) {
          //   context.read<CommunityBoardViewModel>().setIsSafeLoad = true;
          //   context.read<CommunityBoardViewModel>().setIsShowPostDetail(false, false, {});
          //   context
          //     .read<TemplateDesktopViewModel>()
          //     .changeState(context, widget.index, widget.type);
          // } else if (isApprovedPage && context.read<ApprovalViewModel>().getIsSafeClick) {
          //   context.read<ApprovalViewModel>().clearModel();
          //   context.read<ApprovalViewModel>().setIsSafeLoad = true;
          //   context
          //     .read<TemplateDesktopViewModel>()
          //     .changeState(context, widget.index, widget.type);
          // }
          context
            .read<TemplateDesktopViewModel>() 
            .changeState(context, widget.index, 1);
          context.read<TextSearch>().clearSearchText();
          switch (widget.index) {
            case 0:
              if (state) {
                break;
              }
              context
                  .read<CommunityBoardViewModel>()
                  .setIsShowPostDetail(false, false, {});
              context.read<CommunityBoardViewModel>().clearController();
              context.read<CommunityBoardViewModel>().clearPost();
              // context.read<TemplateDesktopViewModel>().setIsApprovedPage =
              //     false;
              // context
              //     .read<TemplateDesktopViewModel>()
              //     .changeState(context, 0, 2);
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const CommunityBoardView();
              }), (route) => false);
              break;
            case 1:
              if (state) {
                break;
              }
              context.read<HelpDeskViewModel>().setIsFormNoti = false;
              context.read<CommunityBoardViewModel>().setIsSafeClick =
                  true;
              context
                  .read<HelpDeskViewModel>()
                  .setShowMessagePageState(false);
              context.read<HelpDeskViewModel>().clearContentController();
              context.read<HelpDeskViewModel>().clearModel();
              context.read<HelpDeskViewModel>().clearReplyDocId();
              int? role =
                  context.read<AppViewModel>().app.getUser.getRole;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HelpDeskMainView(
                          isAdmin: role == 0 ? true : false)),
                  (route) => false);
              break;
            case 2:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return RoleManagementView(isAdmin: isAdmin);
              }), (route) => false);
              break;
            case 3:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(
                context, 
                 MaterialPageRoute(builder: ((context) {
                  return TeacherContactView(
                      isAdmin: context
                              .watch<AppViewModel>()
                              .app
                              .getUser
                              .getRole ==
                          0);
                })), 
                (route) => false
              );
              break;
            case 4:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(
                context, 
                MaterialPageRoute(builder: ((context) {
                  return const RoomReservationView();
                })), 
                (route) => false
              );
              break;
            case 5:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) {
                return const ItemReservationView();
              })), (route) => false);
              break;
            case 6:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) {
                return const MyBookingView();
              })), (route) => false);
              break;
            case 7:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) {
                  return const ScheduleRoomView();
                })), (route) => false);
              break;
            case 8:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return StatisticView(isAdmin: isAdmin);
              }), (route) => false);
              break;
            case 9:
              if (state) {
                break;
              }
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) {
                return const AdminRoom();
              })), (route) => false);
              break;
            default:
          }
        },
      ),
    );
  }
}
