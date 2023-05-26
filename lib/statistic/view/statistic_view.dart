import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_project/core/template/template_desktop/view/page/template_desktop.dart';
import 'package:senior_project/core/view_model/app_view_model.dart';
import 'package:senior_project/statistic/model/statistic_model.dart';
import 'package:senior_project/statistic/view/widget/statistic_grid_view.dart';
import 'package:senior_project/statistic/view_model/statistic_view_model.dart';

class StatisticView extends StatefulWidget {
  final bool isAdmin;
  const StatisticView({super.key, required this.isAdmin});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  List<List<Chart>> data = [];
  List<TicketCommentModel> comments = [];

  List<double> parameters = [];

  bool isMobileSite = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  @override
  Widget build(BuildContext context) {
    if (widget.isAdmin && !isMobileSite) {
      return TemplateDesktop(
        helpdesk: false,
        helpdeskadmin: false,
        home: false,
        useTemplatescroll: true,
        content: FutureBuilder(
          future: context.read<StatisticViewModel>().fetchPage(
              context.watch<StatisticViewModel>().startDate,
              context.watch<StatisticViewModel>().endDate),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Has error ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              data = [];
              final ticketVolume = snapshot.data?.ticketVolume ?? [];
              final ticketStatus = snapshot.data?.ticketStatus ?? [];
              final ticketPriority = snapshot.data?.ticketPriority ?? [];
              final ticketCategory = snapshot.data?.ticketByCategories ?? [];
              final defaultStatistics = snapshot.data?.defaultStatistics ?? [];
              data.add(ticketVolume);
              data.add(ticketStatus);
              data.add(ticketPriority);
              data.add(ticketCategory);
              data.add(defaultStatistics);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    StatisticGridView(
                      data: data,
                      commentData: comments,
                    )
                  ],
                ),
              );
            }
            return const Padding(
              padding: EdgeInsets.only(top: 36),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        ));
    } else {
      return Container();
    }
  }
}
