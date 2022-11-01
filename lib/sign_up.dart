import 'package:auth/sign_in.dart';
import 'package:auth/textform.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Homepage.dart';
import 'constant.dart';
import 'controllers.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isChecked = false;

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
                      "Sign Up",
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
                    textinputfield(
                      text: "Confirm Password",
                      isObscure: true,
                      icon: Icons.lock_outline,
                      controllers: confirmpassword,
                      textcolor: textcolor,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Please enter confirm password';
                        } else {
                          if (!regex.hasMatch(val)) {
                            return 'Enter valid password ex ABc98@98';
                          } else {
                            null;
                          }
                        }
                        if (val != password.text) {
                          return "password is not same";
                        }
                      },
                    ),
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
                            SignUp(email.text, password.text);
                          },
                          child: Text("Sign Up")),
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
                      'already registered',
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
                            MaterialPageRoute(builder: (context) => sign_in()));
                      },
                      child: Text(
                        'Login',
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

  SignUp(String emailAddress, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => sign_in()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          var snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'On Snap!',
              message:
                  'The account already exists for that email.Try different',
              contentType: ContentType.failure,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
