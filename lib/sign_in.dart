import 'package:auth/Homepage.dart';
import 'package:auth/sign_up.dart';
import 'package:auth/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant.dart';
import 'controllers.dart';
import 'resetpassord.dart';

class sign_in extends StatefulWidget {
  const sign_in({Key? key}) : super(key: key);

  @override
  State<sign_in> createState() => _sign_inState();
}

class _sign_inState extends State<sign_in> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final storage = new FlutterSecureStorage();
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#001921"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 101, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 34,
                          color: HexColor("#FFFFFF"),
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Arcu vitae elementum proin sed.",
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor("#99A2AB"),
                        fontFamily: 'SF Pro Display',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    textinputfield(
                        icon: Icons.person,
                        text: "Email Address",
                        controllers: email,
                        textcolor: textcolor,
                        validator: validateEmail),
                    SizedBox(
                      height: 20,
                    ),
                    textinputfield(
                        text: "Password",
                        isObscure: true,
                        icon: Icons.lock_outline,
                        controllers: password,
                        textcolor: textcolor,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Please enter password';
                          } else {
                            if (!regex.hasMatch(val)) {
                              return 'Enter valid password ex ABc98@98';
                            } else {
                              return null;
                            }
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 0.1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3))),
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor:
                                      Color.fromRGBO(255, 255, 255, 0.1),
                                ),
                                child: Checkbox(
                                  //shape: RoundedRectangleBorder(side: BorderSide.none),
                                  side: BorderSide.none,
                                  checkColor: Colors.white,
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                fontSize: 14,
                                color: HexColor("#99A2AB"),
                                fontFamily: 'SF Pro Display',
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => forgot_page()));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                              color: HexColor("#99A2AB"),
                              fontFamily: 'SF Pro Display',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  HexColor('#07A279'))),
                          onPressed: () {
                            SignIn(email.text, password.text);
                          },
                          child: Text("Login")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not registered?',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(255, 255, 255, 0.6)),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Sign_up()));
                      },
                      child: Text(
                        'Click Here',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.greenAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SignIn(String emailAddress, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        await storage.write(key: 'uid', value: userCredential.user!.uid);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
        print("User Login Successfully");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }


}
