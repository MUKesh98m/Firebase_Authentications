import 'package:auth/Homepage.dart';
import 'package:auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
// import com.facebook.FacebookSdk;
// import com.facebook.appevents.AppEventsLogger;

class socialmedialogin extends StatefulWidget {
  const socialmedialogin({Key? key}) : super(key: key);

  @override
  State<socialmedialogin> createState() => _socialmedialoginState();
}

class _socialmedialoginState extends State<socialmedialogin> {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignInButton(
                Buttons.google,
                onPressed: () {
                  signInWithGoogle();
                },
              ),
              SignInButton(
                Buttons.facebook,
                mini: true,
                onPressed: () {},
              ),
              SignInButtonBuilder(
                text: 'Sign in with Email',
                icon: Icons.email,
                onPressed: () {},
                backgroundColor: Colors.blueGrey.shade700,
              ),
            ]),
      ),
    );
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
    print(googleUser?.email);
    await storage.write(key: 'guid', value: credential.accessToken);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Homepage()));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
