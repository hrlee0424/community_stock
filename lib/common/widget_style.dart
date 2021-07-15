import 'package:community_stock/common/color.dart';
import 'package:flutter/material.dart';

import '../view/writeboard.dart';

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

  Widget showAppbar(context, title){
    return AppBar(
      title: Text(title),
      backgroundColor: CommonColor().basicColor,
      actions: [
        new IconButton(icon: new Icon(Icons.add),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder : (context) => WriteBoard()));
            })
      ],
    );
  }
}
