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

  Widget showAppbar(context, title) {
    return AppBar(
      title: Text(title),
      backgroundColor: CommonColor().basicColor,
      actions: [
        new IconButton(icon: new Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WriteBoard()));
            })
      ],
    );
  }

  Widget showColumListItem(context, IconData icon, String title) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Padding(padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          child: Row(
            children: [
              Container(
                child: Icon(
                  icon,
                  color: Colors.black87,
                  size: 22,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(title, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                ),
              ),
              Expanded(flex: 1,
                  child: Container(
                    child: Text(''),
                  )),
              Container(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.black87,
                  size: 25,
                ),
              )
            ],
          ),),
      ),);
  }


}
