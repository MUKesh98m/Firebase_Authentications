import 'package:auth/Homepage.dart';
import 'package:auth/sign_in.dart';
import 'package:auth/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:auth/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authenticationlink.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Future<bool?> checkLoginStatus() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String value = sp.getString('uid').toString();
    if (value == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.data == false) {
              return sign_in();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: Colors.white,
              );
            }
            return Homepage();
          },
        ));
  }
}
