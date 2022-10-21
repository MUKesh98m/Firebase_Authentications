import 'package:auth/sign_in.dart';
import 'package:auth/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:hexcolor/hexcolor.dart';

import 'constant.dart';

class forgot_page extends StatefulWidget {
  const forgot_page({Key? key}) : super(key: key);

  @override
  State<forgot_page> createState() => _forgot_pageState();
}

class _forgot_pageState extends State<forgot_page> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();

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
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 36,
                    height: 36,
                    child: IconButton(
                        padding: EdgeInsets.only(bottom: 1),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                        )),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
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
                                "Forgot Password?",
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
                      validator: validateEmail,
                      icon: Icons.lock_open_sharp,
                      text: "Email Address"),
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
                            sendResetpassword();
                          }
                        },
                        child: Text("Send Reset Instruction")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  sendResetpassword() async {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.sendPasswordResetEmail(email: user!.email.toString());
    print(user.email);
    FirebaseAuth.instance.signOut();
    await storage.delete(key: 'uid');
    Navigator.push(context, MaterialPageRoute(builder: (context) => sign_in()));
  }
}
