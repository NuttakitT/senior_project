import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TextMessage extends StatelessWidget {
  final String text;
  final bool isSender;
  final bool isMobile;
  final String? imageUrl;
  const TextMessage({
    Key? key,
    required this.text,
    required this.isSender,
    required this.isMobile, 
    this.imageUrl
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: isMobile ? 160 : 420),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
          color:
              ColorConstant.whiteBlack15.withOpacity(!isSender ? 1 : 0.4),
          borderRadius: isSender 
          ? const BorderRadius.only(
              topLeft: Radius.circular(24), 
              topRight: Radius.circular(24),
              bottomLeft: Radius.circular(24)
            )
          : const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24)
          )
      ),
      child: Builder(
        builder: (context) {
          if (imageUrl == null) {
            return Text(
              text,
              style: const TextStyle(
                color: ColorConstant.whiteBlack80, 
                fontSize: 16
              )
            ); 
          }
          return Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Builder(
                builder: (context) {
                  if (text.isEmpty) {
                    return Container();
                  }
                  return Text(
                    text,
                    style: const TextStyle(
                      color: ColorConstant.whiteBlack80, 
                      fontSize: 16
                    )
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.network(imageUrl!),
              ),
            ],
          );
        }
      )
    );
  }
}