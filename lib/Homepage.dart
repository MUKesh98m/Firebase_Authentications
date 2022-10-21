import 'package:auth/profile%20page.dart';
import 'package:auth/sign_in.dart';
import 'package:auth/updatepassword.dart';
import 'package:auth/verifyemail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_frosted_bottom_bar/app/frosted_bottom_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexcolor/hexcolor.dart';

import 'resetpassord.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final storage = new FlutterSecureStorage();

  final List<Color> colors = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
  ];

  @override
  void initState() {
    currentPage = 0;
    tabController = TabController(length: 3, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
    super.initState();
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
      body: FrostedBottomBar(
        opacity: 0.6,
        sigmaX: 5,
        sigmaY: 5,
        child: TabBar(
          indicatorPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          controller: tabController,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.blue, width: 4),
            insets: EdgeInsets.fromLTRB(16, 0, 16, 8),
          ),
          tabs: [
            TabsIcon(
                icons: Icons.home,
                color: currentPage == 0 ? colors[0] : Colors.white),
            TabsIcon(
                icons: Icons.search,
                color: currentPage == 1 ? colors[1] : Colors.white),
            TabsIcon(
                icons: Icons.queue_play_next,
                color: currentPage == 2 ? colors[2] : Colors.white),
          ],
        ),
        borderRadius: BorderRadius.circular(500),
        duration: const Duration(milliseconds: 800),
        hideOnScroll: true,
        body: (context, controller) => TabBarView(
            controller: tabController,
            dragStartBehavior: DragStartBehavior.down,
            physics: const BouncingScrollPhysics(),
            children: [
              update_password(),
              forgot_page(),
              verifyemail(),
            ]),
      ),
    );
  }
}

class TabsIcon extends StatelessWidget {
  final Color color;
  final double height;
  final double width;
  final IconData icons;

  const TabsIcon(
      {Key? key,
      this.color = Colors.white,
      this.height = 60,
      this.width = 50,
      required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: Icon(
          icons,
          color: color,
        ),
      ),
    );
  }
}
