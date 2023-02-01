import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class PopupSubMenuItem<T> extends PopupMenuEntry<T> {
  const PopupSubMenuItem({super.key, 
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
        return widget.items.map(
              (item) => PopupMenuItem<T>(
            value: item,
            child: Text(
              item.toString(),
              style: const TextStyle(
                fontFamily: ColorConstant.font,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorConstant.whiteBlack80
              ),
            ),
          ),
        ).toList();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 11.5, 0 ,11.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Change ${widget.title}",
              style: const TextStyle(
                fontFamily: ColorConstant.font,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorConstant.whiteBlack80
              ),
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  const ActionButton({super.key});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
            items: const ["Not start", "In progress", "Done"],
            onSelected: (value) {
              // TODO change status logic
            }
          ),
          PopupSubMenuItem(
            title: "Priority", 
            items: const ["Urgent", "High", "Medium", "Low"],
            onSelected: (value) {
              // TODO change priority logic
            }
          ),
          PopupMenuItem(
            value: 3,
            child: const Text(
              "Message",
              style: TextStyle(
                fontFamily: ColorConstant.font,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: ColorConstant.whiteBlack80
              ),
            ),
            onTap: () {
              // TODO change to reply channel page
            },
          ),
        ];
      },
    );
  }
}