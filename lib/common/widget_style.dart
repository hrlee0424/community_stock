import 'package:flutter/material.dart';

class WidgetCustom {
  Widget showBtn(double paddingTop, Text text, getFunction, Color backColor) {
    return Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Container(
          width: double.infinity,
          child: MaterialButton(
            height: 50,
            child: text,
            onPressed: () {
              getFunction();
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            color: backColor,
          ),
        ));
  }
}
