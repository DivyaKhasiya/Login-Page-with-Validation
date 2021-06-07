import 'package:flutter/material.dart';

InputDecoration buildInputDecoration(String text,TextStyle textStyle){
return InputDecoration(
  labelStyle: textStyle,
  labelText: text,

  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.red)),
);
}