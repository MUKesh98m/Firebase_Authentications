import 'package:auth/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, this.useremail, this.isLogOutKey})
      : super(key: key);
  final useremail;
  final isLogOutKey;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, // <-- SEE HERE
          ),
          title: Text("ORDO",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25)),
          backgroundColor: HexColor("#001921"),
          actions: [
            IconButton(
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  await storage.delete(key: 'uid');
                  print(storage.delete(key: 'uid'));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => sign_in()));

                  setState(() {});
                },
                icon: Icon(Icons.logout_rounded))
          ],
        ),
        drawer: Drawer(
          backgroundColor: HexColor("#001921"),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-vector/mysterious-mafia-man-smoking-cigarette_52683-34828.jpg?w=740&t=st=1666325855~exp=1666326455~hmac=1173f61c7fb141f27d8ba08abb318bde83e084ed8ba3468ab1e130dee2d6dc04"),
                    maxRadius: 35,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Mukesh Mahaja",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Text(widget.useremail ?? 'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20))
                ],
              )),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Page 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.train,
                ),
                title: const Text('Page 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Center(),
      ),
    );
  }
}
