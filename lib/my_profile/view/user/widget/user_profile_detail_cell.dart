import 'package:flutter/material.dart';
import '../../../../assets/font_style.dart';

class UserProfileDetailCell extends StatefulWidget {
  static TextStyle informationHeaderTextStyle = AppFontStyle.wb80Md20;
  static TextStyle informationTitleTextStyle = AppFontStyle.wb40R16;
  static TextStyle informationDetailTextStyle = AppFontStyle.wb80R18;

  const UserProfileDetailCell({
    Key? key,
    required this.cellTitle,
    required this.leftCellTitle,
    required this.leftCellDetail,
    required this.rightCellTitle,
    required this.rightCellDetail,
    required this.isBorderNeeded,
  }) : super(key: key);

  final String cellTitle;
  final String? leftCellTitle;
  final String? leftCellDetail;
  final String? rightCellTitle;
  final String? rightCellDetail;
  final bool isBorderNeeded;

  @override
  State<UserProfileDetailCell> createState() => _UserProfileDetailCellState();
}

class _UserProfileDetailCellState extends State<UserProfileDetailCell> {
  TextEditingController leftFieldTextController =
      TextEditingController(text: '');
  TextEditingController rightFieldTextController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    leftFieldTextController.text = widget.leftCellDetail ?? '';
    rightFieldTextController.text = widget.rightCellDetail ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.isBorderNeeded
          ? const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xFF9C9FA1), width: 1.0)))
          : null,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultTextStyle(
              style: UserProfileDetailCell.informationHeaderTextStyle,
              child: Text(widget.cellTitle)),
          const SizedBox(height: 8),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                if (widget.leftCellDetail != null)
                  Expanded(
                      flex: 1,
                      child: Text(
                        widget.leftCellTitle!,
                        style: UserProfileDetailCell.informationTitleTextStyle,
                        textAlign: TextAlign.left,
                      )),
                if (widget.leftCellDetail != null)
                  Expanded(
                      flex: 3,
                      child: TextField(
                        enabled: true,
                        controller: leftFieldTextController,
                        style: UserProfileDetailCell.informationDetailTextStyle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                if (widget.rightCellDetail != null)
                  Expanded(
                      flex: 1,
                      child: Text(
                        widget.rightCellTitle!,
                        style: UserProfileDetailCell.informationTitleTextStyle,
                        textAlign: TextAlign.left,
                      )),
                if (widget.rightCellDetail != null)
                  Expanded(
                      flex: 3,
                      child: TextField(
                        enabled: true,
                        controller: rightFieldTextController,
                        style: UserProfileDetailCell.informationDetailTextStyle,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      )),
                if (widget.rightCellDetail == null)
                  Expanded(flex: 4, child: Container())
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class UserProfileDetailCell extends StatelessWidget {
//   static TextStyle informationHeaderTextStyle = AppFontStyle.wb80Md20;
//   static TextStyle informationTitleTextStyle = AppFontStyle.wb40R16;
//   static TextStyle informationDetailTextStyle = AppFontStyle.wb80R18;

//   const UserProfileDetailCell(
//       {Key? key,
//       required this.cellTitle,
//       required this.leftCellTitle,
//       required this.leftCellDetail,
//       required this.rightCellTitle,
//       required this.rightCellDetail,
//       required this.isBorderNeeded})
//       : super(
//           key: key,
//         );

//   final String cellTitle;
//   final String? leftCellTitle;
//   final String? leftCellDetail;
//   final String? rightCellTitle;
//   final String? rightCellDetail;
//   final bool isBorderNeeded;

//   @override
//   Widget build(BuildContext context) {
//     if (leftCellDetail == null && rightCellDetail == null) {
//       return Container();
//     }
//     TextEditingController leftFieldTextController =
//         TextEditingController(text: leftCellDetail);
//     TextEditingController rightFieldTextController =
//         TextEditingController(text: rightCellDetail);

//     return Container(
//       decoration: isBorderNeeded
//           ? const BoxDecoration(
//               border: Border(
//                   bottom: BorderSide(color: Color(0xFF9C9FA1), width: 1.0)))
//           : null,
//       padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           DefaultTextStyle(
//               style: informationHeaderTextStyle, child: Text(cellTitle)),
//           const SizedBox(height: 8),
//           Padding(
//             padding:
//                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             child: Row(
//               children: [
//                 if (leftCellDetail != null)
//                   Expanded(
//                       flex: 1,
//                       child: Text(
//                         leftCellTitle!,
//                         style: informationTitleTextStyle,
//                         textAlign: TextAlign.left,
//                       )),
//                 if (leftCellDetail != null)
//                   Expanded(
//                       flex: 3,
//                       child: TextField(
//                         enabled: true,
//                         controller: leftFieldTextController,
//                         style: informationDetailTextStyle,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                       )),
//                 if (rightCellDetail != null)
//                   Expanded(
//                       flex: 1,
//                       child: Text(
//                         rightCellTitle!,
//                         style: informationTitleTextStyle,
//                         textAlign: TextAlign.left,
//                       )),
//                 if (rightCellDetail != null)
//                   Expanded(
//                       flex: 3,
//                       child: TextField(
//                         enabled: true,
//                         controller: rightFieldTextController,
//                         style: informationDetailTextStyle,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                       )),
//                 if (rightCellDetail == null)
//                   Expanded(flex: 4, child: Container())
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
