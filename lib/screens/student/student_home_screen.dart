import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StudentHomeScreen extends StatelessWidget {
  StudentHomeScreen({required this.startQuiz, super.key});
  final void Function() startQuiz;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<void> handleLogout() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      UserService().updateUserStatusToOffline(user.uid);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Config.alabasterColor,
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Config.earthYellowColor,
                  ),
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ยินดีต้อนรับ",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "คุณ ${_auth.currentUser?.email}",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              child: IconButton.outlined(
                                  onPressed: () async {
                                    await handleLogout();
                                    await FirebaseServices()
                                        .signOut()
                                        .whenComplete(
                                            () => {Navigator.pop(context)});
                                  },
                                  icon: FaIcon(
                                    FontAwesomeIcons.arrowRightToBracket,
                                    size: 30,
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Config.antiFlashWhiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Quiz #1"),
                                Text("Topic : Fultter"),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: TextButton.icon(
                              style: TextButton.styleFrom(
                                  backgroundColor: Config.earthYellowColor),
                              onPressed: startQuiz,
                              icon: Icon(
                                Icons.arrow_forward_outlined,
                                color: Config.onyxColor,
                              ),
                              label: Text(
                                "Start Quiz!",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Config.onyxColor),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
