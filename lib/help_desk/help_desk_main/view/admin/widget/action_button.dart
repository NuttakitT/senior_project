import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class PopupSubMenuItem<T> extends PopupMenuEntry<T> {
  const PopupSubMenuItem({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
  });

  final String title;
  final List<T> items;
  final Function(T) onSelected;

  @override
  State createState() => _PopupSubMenuState<T>();

  @override
  double get height => kMinInteractiveDimension;

  @override
  bool represents(T? value) => false;
}

class _PopupSubMenuState<T> extends State<PopupSubMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      tooltip: "show ${widget.title.toLowerCase()} menu",
      onCanceled: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      onSelected: (T value) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        widget.onSelected.call(value);
      },
      offset: const Offset(110, -7),
      itemBuilder: (BuildContext context) {
        return widget.items
            .map(
              (item) => PopupMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                  style: AppFontStyle.wb80R14,
                ),
              ),
            )
            .toList();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 11.5, 0, 11.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Change ${widget.title}",
              style: AppFontStyle.wb80R14,
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final String id;
  const ActionButton({super.key, required this.id});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  List<String> status = const ["Not start", "In progress", "Done"];
  List<String> priority = const ["Low", "Medium", "High", "Urgent"];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: ColorConstant.orange10),
      child: PopupMenuButton(
        icon: const RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.keyboard_control,
          ),
        ),
        itemBuilder: (context) {
          return <PopupMenuEntry>[
            PopupSubMenuItem(
                title: "Status",
                items: status,
                onSelected: (value) async {
                  int newStatus = status.indexOf(value);
                  await context.read<HelpDeskViewModel>().editTask(widget.id, true, newStatus);
                }),
            PopupSubMenuItem(
                title: "Priority",
                items: priority,
                onSelected: (value) async {
                  int newPriority = priority.indexOf(value);
                  await context.read<HelpDeskViewModel>().editTask(widget.id, false, newPriority);
                }),
            PopupMenuItem(
              value: 3,
              child: const Text(
                "Message",
                style: AppFontStyle.wb80R14,
              ),
              onTap: () {
                // TODO change to reply channel page
              },
            ),
          ];
        },
      ),
    );
  }
}
