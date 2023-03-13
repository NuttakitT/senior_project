import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/assets/color_constant.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';
import 'package:senior_project/core/template_desktop/view_model/template_desktop_view_model.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
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

class TagBarHelpDesk extends StatefulWidget {
  final String name;
  final bool state;
  final int index;
  final String id;
  const TagBarHelpDesk({
    super.key,
    required this.name,
    required this.index,
    required this.state,
    required this.id
  });

  @override
  State<TagBarHelpDesk> createState() => _TagBarHelpDeskState();
}

class _TagBarHelpDeskState extends State<TagBarHelpDesk> {
  int oldAmount = 0;
  Stream? _stream;

  @override
  void didChangeDependencies() {
    context.read<HelpDeskViewModel>().cleanModel();
    _stream = query(widget.id, widget.index);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = context.watch<AppViewModel>().isLogin;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: widget.state == true
                  ? ColorConstant.orange20
                  : ColorConstant.blue0,
              borderRadius: BorderRadius.circular(8)),
          height: 40,
          width: 280,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: AppFontStyle.wb80R20,
                  textAlign: TextAlign.left,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.state == true
                        ? ColorConstant.white
                        : ColorConstant.blue5),
                  height: 24,
                  width: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Builder(
                    builder: (context) {
                      if (!isLogin) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: ColorConstant.whiteBlack80),
                        );
                      }
                      return StreamBuilder(
                        stream: _stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.active) {
                            if (snapshot.hasData) {
                              oldAmount = snapshot.data!.docs.length;
                              return Text(
                                (snapshot.data!.docs.length).toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: ColorConstant.whiteBlack80),
                              );
                            }
                            context.read<HelpDeskViewModel>().cleanModel();
                            return Text(
                              oldAmount.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: ColorConstant.whiteBlack80),
                            );
                          }
                          return Text(
                            oldAmount.toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: ColorConstant.whiteBlack80),
                          );
                        },
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          context.read<TemplateDesktopViewModel>().changeState(widget.index, 4);
        },
      ),
    );
  }
}
