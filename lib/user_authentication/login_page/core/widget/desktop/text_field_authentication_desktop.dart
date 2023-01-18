import 'package:flutter/material.dart';
import 'package:senior_project/assets/constant.dart';

class TextFieldAuthenticationDesktop {
  static Widget widget(String hintText, bool isPasswordField) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Constant.whiteBlack50),
        borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child:  Row(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextField(
                obscureText: isPasswordField,
                decoration: InputDecoration.collapsed(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Constant.whiteBlack30,
                    fontFamily: Constant.font,
                    fontWeight: FontWeight.w400,
                    fontSize: 14
                  )
                ),
              ),
            ),
          ),
          const Divider(),
          Builder(
            builder: (context) {
              if(isPasswordField) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // TODO state management password visibility
                    }, 
                    icon: const Icon(
                      Icons.visibility,
                      color: Constant.whiteBlack50,
                    )
                  ),
                );
              }
              return Container();
            }
          )
        ],
      ),
    );
  }
}