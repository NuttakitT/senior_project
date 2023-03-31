import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/help_desk/help_desk_main/view/desktop/replyChannel/set_reply.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_view_model.dart';

class ReplyStream extends StatefulWidget {
  final Stream? stream;
  final int limit;
  final Widget body;
  final Widget loder;
  const ReplyStream({
    super.key, 
    required this.stream, 
    required this.limit,
    required this.body,
    required this.loder,
  });

  @override
  State<ReplyStream> createState() => _ReplyStreamState();
}

class _ReplyStreamState extends State<ReplyStream> {
  @override
  Widget build(BuildContext context) {
    context.read<HelpDeskViewModel>().clearModel();
    context.read<HelpDeskViewModel>().setIsSafeClick = false;

    return StreamBuilder(
      stream: widget.stream,
      builder: (context, streamSnapshot) {
        if (streamSnapshot.connectionState == ConnectionState.active) {
          if (streamSnapshot.data!.docs.isNotEmpty) {
            context.read<HelpDeskViewModel>().setFirstDoc(streamSnapshot.data.docs.first);
            context.read<HelpDeskViewModel>().setLastDoc(streamSnapshot.data.docs.last);
            context.read<HelpDeskViewModel>().addPreviousFirst = context.read<HelpDeskViewModel>().getFirstDoc!.id;
            return FutureBuilder(
              future: context.read<HelpDeskViewModel>().reconstructQueryData(streamSnapshot.data as QuerySnapshot),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.done) {
                  return FutureBuilder(
                    future: context.read<HelpDeskViewModel>().formatTaskDetail(),
                    builder: (context, _) {
                      if (_.connectionState == ConnectionState.done) {
                        context.read<HelpDeskViewModel>().setIsSafeClick = true;
                        SetReply.setReplyPageData(context, widget.limit);
                        return widget.body;
                      }
                      return widget.loder;
                    },
                  );
                }
                return widget.loder;
              },
            );
          }
          context.read<HelpDeskViewModel>().setIsSafeClick = true;
          return widget.body;
        }
        return widget.loder;
      },
    );
  }
}