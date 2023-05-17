import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/assets/font_style.dart';
import 'package:senior_project/facility/model/facility_model.dart';

class BookingCardView extends StatefulWidget {
  final BookingCard cardDetail;
  const BookingCardView({super.key, required this.cardDetail});

  @override
  State<BookingCardView> createState() => _BookingCardViewState();
}

class _BookingCardViewState extends State<BookingCardView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookCardViewCell(title: "Type", detail: widget.cardDetail.title),
        BookCardViewCell(title: "Detail", detail: widget.cardDetail.detail),
        BookCardViewCell(title: "Create", detail: widget.cardDetail.createTime),
        BookCardViewCell(
            title: "Book time", detail: widget.cardDetail.requestTime),
        BookCardViewCell(title: "Status", detail: widget.cardDetail.status),
      ],
    );
  }
}

class BookCardViewCell extends StatelessWidget {
  final String title;
  final String detail;
  const BookCardViewCell({Key? key, required this.title, required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobileSite = kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    return Column(
      children: [
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
                flex: isMobileSite ? 2 : 1,
                child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb80R16
                        : AppFontStyle.wb80R20,
                    child: Text(title))),
            Expanded(
                flex: isMobileSite ? 5 : 7,
                child: DefaultTextStyle(
                    style: isMobileSite
                        ? AppFontStyle.wb60Md16
                        : AppFontStyle.wb60Md20,
                    child: Text(detail))),
          ],
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
