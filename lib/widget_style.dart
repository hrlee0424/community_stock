import 'package:flutter/material.dart';

class WidgetCustom{
  Widget showBtn(Text text, getFunction) {
    return Padding(
        padding: EdgeInsets.only(top: 50),
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
            color: Colors.amberAccent,
          ),
        ));
  }

}