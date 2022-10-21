import 'package:auth/Homepage.dart';
import 'package:auth/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';

class AuthenticationLinksend extends StatefulWidget {
  const AuthenticationLinksend({Key? key}) : super(key: key);

  @override
  State<AuthenticationLinksend> createState() => _AuthenticationLinksendState();
}

class _AuthenticationLinksendState extends State<AuthenticationLinksend> {
  TextEditingController email = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String name = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setvalue();
  }

  setvalue() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    name = sp.getString('email')!;
  }

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
                              width: 235,
                              // color: Colors.greenAccent,
                              child: Text(
                                "Authentication Link",
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
                            SharedPreferences sp =
                                await SharedPreferences.getInstance();
                            sp.setString('email', email.text);
                            sp.getString('email');
                            setState(() {});
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Homepage(
                                          useremail: name,
                                        )));
                            // name = sp.getString('email').toString();
                          }
                        },
                        child: Text("Send Reset Instruction")),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
