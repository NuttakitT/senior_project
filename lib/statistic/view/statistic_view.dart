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
  List<List<Chart>> data = [
    // ticket volume
    [
      LineChartModel(x: 1, y: 2),
      LineChartModel(x: 2, y: 2),
      LineChartModel(x: 3, y: 7),
      LineChartModel(x: 4, y: 20),
    ],
    [
      PieChartModel(title: "A", data: 20),
      PieChartModel(title: "B", data: 20),
      PieChartModel(title: "C", data: 20),
      PieChartModel(title: "D", data: 20),
    ]
  ];
  @override
  Widget build(BuildContext context) {
    bool isMobileSite = context
        .watch<AppViewModel>()
        .getMobileSiteState(MediaQuery.of(context).size.width);
    if (widget.isAdmin && !isMobileSite) {
      return FutureBuilder(
          future: context.read<StatisticViewModel>().fetchPage(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('Has error ${snapshot.error}');
            }
            if (snapshot.connectionState == ConnectionState.done) {
              // final admins = snapshot.data?.admins ?? [];
              // final categories = snapshot.data?.categories ?? [];
              return TemplateDesktop(
                  helpdesk: false,
                  helpdeskadmin: false,
                  home: false,
                  useTemplatescroll: true,
                  content: SingleChildScrollView(
                    child: Column(
                      children: [StatisticGridView(data: data)],
                    ),
                  ));
            }
            return const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(),
              ),
            );
          }));
    } else {
      return Container();
    }
  }
}
