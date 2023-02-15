import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(
        0xFF9C9FA1,
      ),
      height: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}

class CommonVerticalDivider extends StatelessWidget {
  const CommonVerticalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      color: Color(
        0xFF9C9FA1,
      ),
      width: 1,
      thickness: 1,
      indent: 0,
      endIndent: 0,
    );
  }
}
