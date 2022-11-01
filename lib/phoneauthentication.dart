import 'package:auth/Homepage.dart';
import 'package:auth/resetpassord.dart';
import 'package:auth/sign_in.dart';
import 'package:auth/textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pinput.dart';

import 'constant.dart';

class phoneauthentication extends StatefulWidget {
  const phoneauthentication({Key? key}) : super(key: key);

  @override
  State<phoneauthentication> createState() => _phoneauthenticationState();
}

class _phoneauthenticationState extends State<phoneauthentication> {
  TextEditingController number = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final storage = new FlutterSecureStorage();
  TextEditingController _codeController = new TextEditingController();
  String smsCode = '';

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
                                "Authenticate Phone",
                                style: TextStyle(
                                    fontSize: 33,
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
                      controllers: number,
                      textcolor: Colors.white,
                      validator: validateMobile,
                      icon: Icons.phone,
                      text: "Enter Mobile Number"),
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
                          // alert();
                          if (formKey.currentState!.validate()) {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '+91' + number.text.trim(),
                              timeout: const Duration(seconds: 60),
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {
                                print("Auth Controller");
                                print(credential);
                                FirebaseAuth.instance
                                    .signInWithCredential(credential)
                                    .then((value) async {
                                  if (value != null) {
                                    print(value);
                                  }
                                });
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print(e);
                              },
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("ENTER OTP"),
                                          content: Container(
                                            height: 150,
                                            child: Column(children: [
                                              Pinput(
                                                controller: _codeController,
                                                androidSmsAutofillMethod:
                                                    AndroidSmsAutofillMethod
                                                        .smsRetrieverApi,
                                                forceErrorState: true,
                                                // errorText: 'Error',
                                                length: 6,
                                                pinputAutovalidateMode:
                                                    PinputAutovalidateMode
                                                        .onSubmit,
                                                closeKeyboardWhenCompleted:
                                                    true,
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Container(
                                                width: 385,
                                                height: 48,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                HexColor(
                                                                    '#07A279'))),
                                                    onPressed: () async {
                                                      FirebaseAuth auth =
                                                          FirebaseAuth.instance;
                                                      smsCode = _codeController
                                                          .text
                                                          .trim();
                                                      PhoneAuthCredential
                                                          _credential =
                                                          PhoneAuthProvider
                                                              .credential(
                                                        verificationId:
                                                            verificationId,
                                                        smsCode: smsCode,
                                                      );
                                                      var mukesh = auth
                                                          .signInWithCredential(
                                                              _credential)
                                                          .then((result) {
                                                        if (result != null) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //       builder:
                                                          //           (context) =>
                                                          //               Homepage(),
                                                          //     ));
                                                        }
                                                      }).catchError((e) {
                                                        print(e);
                                                      });

                                                      print(mukesh);
                                                    },
                                                    child: Text("Submit")),
                                              )
                                            ]),
                                          ),
                                        ));
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
                                verificationId = verificationId;
                                print('AUTORETRIVAL SECTION');
                                print(verificationId);
                                print("Timout");
                              },
                            );
                          }
                        },
                        child: Text("Send  Instruction")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
