import 'package:flutter/material.dart';
import 'package:senior_project/community_board/view/desktop/widget/comment_template.dart';
import 'package:senior_project/community_board/view/mobile/widget/comment_template_mobile.dart';
import 'package:senior_project/core/datasource/firebase_services.dart';

class CommentLoader extends StatefulWidget {
  final String docId;
  final bool isMobile;
  const CommentLoader({super.key, required this.docId, required this.isMobile});

  @override
  State<CommentLoader> createState() => _CommentLoaderState();
}

class _CommentLoaderState extends State<CommentLoader> {
  List<Widget> getComment(List<Map<String, dynamic>> data, bool isMobile) {
    List<Widget> list = [];
    for (int i = 0; i < data.length; i++) {
      list.add(
        Padding(
          padding: EdgeInsets.fromLTRB(isMobile ? 16 : 40, 0, isMobile ? 16 : 40, isMobile ? 16 : 24),
          child: isMobile 
          ? CommentTemplateMobile(index: i+1, info: data[i], parentId: widget.docId,) 
          : CommentTemplate(index: i+1, info: data[i], parentId: widget.docId,),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseServices("post").listenToSubDocument(
        widget.docId, 
        "comment",
        orderingField: "dateCreate",
        descending: true
      ),
      builder: (context, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.active) {
          List<Map<String, dynamic>> data= [];
          for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
            data.add({
              "dateCreate": streamSnapshot.data!.docs[i].get("dateCreate").toDate(),
              "dateEdit": streamSnapshot.data!.docs[i].get("dateEdit"),
              "detail": streamSnapshot.data!.docs[i].get("detail"),
              "ownerId": streamSnapshot.data!.docs[i].get("ownerId"),
              "id": streamSnapshot.data!.docs[i].get("id"),
              "parentId": widget.docId
            });
          }
          return Column(
            children: getComment(data, widget.isMobile),
          );
        }
        return Container();
      },
    );
  }
}