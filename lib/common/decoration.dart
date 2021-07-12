import 'package:flutter/material.dart';

class FormDecoration{

  InputDecoration textFormDecoration(hintText, helperText) {
    return new InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 15),
      hintText: hintText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      // helperText: helperText,
    );
  }

}