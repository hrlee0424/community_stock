import 'package:flutter/material.dart';

import 'color.dart';

class FormDecoration{

  InputDecoration textFormDecoration(labelText, hintText, helperText) {
    return new InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: CommonColor().basicColor),
      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      hintText: hintText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: CommonColor().basicColor)
      )
      // helperText: helperText,
    );
  }

}