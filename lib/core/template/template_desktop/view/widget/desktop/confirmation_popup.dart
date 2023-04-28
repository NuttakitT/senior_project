import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';

class ConfirmationPopup extends StatefulWidget {
  final String title;
  final String detail;
  final Widget? widget;
  final Function() onCancel;
  final Function() onConfirm;

  const ConfirmationPopup(
      {super.key,
      required this.title,
      required this.detail,
      required this.widget,
      required this.onCancel,
      required this.onConfirm});

  @override
  State<ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<ConfirmationPopup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: ColorConstant.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: SizedBox(
          width: 450,
          height: 320,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DefaultTextStyle(
                          style: AppFontStyle.orange70Md28,
                          child: Text(widget.title, maxLines: 3)),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: AppFontStyle.wb60L18,
                  child: Text(widget.detail, maxLines: 5),
                ),
                widget.widget ?? Container(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 144,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: ColorConstant.whiteBlack60),
                      ),
                      child: TextButton(
                        onPressed: () {
                          widget.onCancel();
                        },
                        child: Text(Consts.cancel,
                            style: AppFontStyle.wb60SemiB16),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      height: 40,
                      width: 144,
                      decoration: BoxDecoration(
                        color: ColorConstant.orange40,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(
                        onPressed: () {
                          widget.onConfirm();
                        },
                        child:
                            Text(Consts.confirm, style: AppFontStyle.whiteB16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class Consts {
  static String confirm = "Confirm";
  static String cancel = "Cancel";
}
