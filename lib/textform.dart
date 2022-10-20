import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class textinputfield extends StatelessWidget {
  const textinputfield({
    Key? key,
    this.icon,
    this.text,
    this.maxlength,
    this.suffixicon,
    this.suffixiconcolor,
    this.validator,
    this.controllers,
    this.isObscure = false,
    this.textcolor,
    this.keyboardtype,
    this.onchanged,
  }) : super(key: key);
  final icon;
  final text;
  final maxlength;
  final suffixicon;
  final suffixiconcolor;
  final validator;
  final controllers;
  final isObscure;
  final textcolor;
  final keyboardtype;
  final onchanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxlength,
      validator: validator,
      controller: controllers,
      onChanged: onchanged,
      obscureText: isObscure,
      style: TextStyle(color: textcolor),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10),
          hintText: text,
          suffixIcon: Icon(suffixicon, color: suffixiconcolor),
          hintStyle: TextStyle(color: HexColor("#99A2AB")),
          filled: true,
          fillColor: Color.fromRGBO(255, 255, 255, 0.1),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          prefixIconColor: Colors.white,
          prefixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                icon,
                color: Colors.white,
              ))),
    );
  }
}
