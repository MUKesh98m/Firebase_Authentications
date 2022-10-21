import 'package:auth/sign_in.dart';
import 'package:auth/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:hexcolor/hexcolor.dart';

import 'constant.dart';

class update_password extends StatefulWidget {
  const update_password({Key? key}) : super(key: key);

  @override
  State<update_password> createState() => _update_passwordState();
}

class _update_passwordState extends State<update_password> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001921"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      width: 300,
                      height: 180,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 200,
                              // color: Colors.greenAccent,
                              child: Text(
                                "Update Password?",
                                style: TextStyle(
                                    fontSize: 34,
                                    color: HexColor("#FFFFFF"),
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.7),
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Enter the email address you used when \n you joined and we’ll send you a link to \n reset your password.",
                            style: TextStyle(
                                height: 1.4,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: HexColor("#99A2AB")),
                          )
                        ],
                      )),
                  textinputfield(
                      controllers: email,
                      textcolor: Colors.white,
                      icon: Icons.lock_open_sharp,
                      text: "Change password"),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 385,
                    height: 48,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(HexColor('#07A279'))),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            updatepassword();
                          }
                        },
                        child: Text("Update Password")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;

  updatepassword() async {
    try {
      await user?.updatePassword(email.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>sign_in()));
    } catch (e) {
      Fluttertoast.showToast(msg: "error");
    }
  }
}
