import 'package:flutter/material.dart';
import 'package:senior_project/assets/color_constant.dart';

class TableDetail{
  static TextStyle _detailTextStyle(double size, Color color) {
    return TextStyle(
      fontFamily: ColorConstant.font,
      fontWeight: FontWeight.w400,
      color: color,
      fontSize: size
    );
  }

  static List<Widget> widget(Map<String, dynamic> detail) {
    return [
      Flexible(
        flex: 2,
        fit: FlexFit.tight,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0x6629B6F6)
                ),
                child: const Icon(Icons.person)
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detail["username"],
                  style: _detailTextStyle(20, ColorConstant.whiteBlack80),
                ),
                Text(
                  detail["email"],
                  style: _detailTextStyle(12, ColorConstant.whiteBlack60),
                ),
              ],
            )
          ],
        ),
      ),
      Flexible(
        flex: 3,
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: detail["taskHeader"],
                      style: _detailTextStyle(16, ColorConstant.whiteBlack80),
                    )
                  ]
                ),
              ),
              RichText(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: detail["taskDetail"],
                      style: _detailTextStyle(12, ColorConstant.whiteBlack60), 
                    )
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.whiteBlack15),
              borderRadius: BorderRadius.circular(8),
              color: ColorConstant.whiteBlack5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(
                  Icons.keyboard_double_arrow_up, 
                  color: ColorConstant.whiteBlack80,
                  size: 12,
                ),
                Text(
                  detail["priority"],
                  style: _detailTextStyle(12, ColorConstant.whiteBlack80),
                )
              ],
            ),
          ),
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9.5, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: ColorConstant.success30),
              borderRadius: BorderRadius.circular(8),
              color: ColorConstant.success5
            ),
            child: Text(
              detail["status"],
              textAlign: TextAlign.center,
              style: _detailTextStyle(10.5, ColorConstant.success50),
            ),
          ),
        ),
      ),
      Flexible(
        flex: 2,
        fit: FlexFit.tight,
        child: RichText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: detail["category"],
                style: _detailTextStyle(14, ColorConstant.whiteBlack70), 
              )
            ]
          ),
        ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: Text(
            detail["time"],
            style: _detailTextStyle(14, ColorConstant.whiteBlack60),
          ),
      ),
      Flexible(
        fit: FlexFit.tight,
        child: 
        // DropdownButton(
        //   items: [],
        //   onChanged: (value) {
        //     // TODO set provider state
        //   },
        // )
        
        
        RotatedBox(
            quarterTurns: 1,
            child: IconButton(
              iconSize: 20,
              color: ColorConstant.whiteBlack60,
              icon: const Icon(
                Icons.keyboard_control, 
              ),
              onPressed: () {
                // TODO action pop-up
              },
            ),
          ),
      )
    ];
  }

}