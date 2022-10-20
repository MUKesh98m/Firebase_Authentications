import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

var textinputcolor = Colors.red;
var textcolor = Colors.white;

RegExp regex = RegExp('[0-9]');

var butoncolor = HexColor('hexColor');

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!))
    return 'Enter Valid Email ex abc@gmail.com';
  else
    return null;
}

String? validateMobile(String? value) {
// Indian Mobile number are of 10 digit only
  if (value!.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}

String? validateName(String? value) {
  if (value!.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String? validatePassword(String? value) {
  RegExp regex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  if (value!.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password ex ABc98@98';
    } else {
      return null;
    }
  }
}

String? validateConfPassword(String? value) {
  if (value!.isEmpty) {
    return 'Please enter Confirm password';
  } else if (value != validatePassword) {
    return "password is not same";
  } else if (!regex.hasMatch(value)) {
    return 'Enter valid password ex ABc98@98';
  } else {
    return null;
  }
}
