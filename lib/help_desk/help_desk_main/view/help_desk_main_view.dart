import 'package:flutter/material.dart';
import 'package:senior_project/help_desk/help_desk_main/view_model/help_desk_main_view_model.dart';

class HelpDeskMainView extends StatefulWidget {
  const HelpDeskMainView({super.key});

  @override
  State<HelpDeskMainView> createState() => _HelpDeskMainViewState();
}

class _HelpDeskMainViewState extends State<HelpDeskMainView> {
  // TODO: change viewModel to Provider
  HelpDeskMainViewModel viewModel = HelpDeskMainViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(viewModel.getName()),
    );
  }
}
