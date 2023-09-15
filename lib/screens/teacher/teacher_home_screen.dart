import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/teacher/questionform_screen.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/utils/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TeacherHomeScreen extends StatefulWidget {
  TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  List<DocumentSnapshot> onlineUsers = [];

  @override
  void initState() {
    super.initState();
    fetchOnlineUsers();
  }

  Future<void> fetchOnlineUsers() async {
    final onlineUsersList = await UserService().getOnlineUsers();
    setState(() {
      onlineUsers = onlineUsersList;
    });
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
                              "อิรัชชัยมาเซะ",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "เซนเซ",
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('online', isEqualTo: true)
                      .snapshots(), // Replace 'onlineUsers' with your Firestore collection name
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    final onlineUsersDocs = snapshot.data!.docs;
                    onlineUsers = onlineUsersDocs;

                    return onlineUsers.length == 0
                        ? Center(
                            child: Text(
                              "No student currently online.",
                              style: TextStyle(fontSize: 12),
                            ),
                          )
                        : ListView.builder(
                            itemCount: onlineUsers.length,
                            itemBuilder: (context, index) {
                              final userSnapshot = onlineUsers[index];
                              final userData =
                                  userSnapshot.data() as Map<String, dynamic>;
                              final email = userData['email'] as String;
                              final progress =
                                  double.parse(userData['progress'].toString());
                              final status = userData['status'] as String;
                              return _UserCard(email, progress, status);
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        decoration: const BoxDecoration(
          color: Config.alabasterColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: Config.toPopPage(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 20.0,
                  color: Colors.black,
                ),
                label: const Text(
                  'ย้อนกลับ',
                  style: TextStyle(
                    fontFamily: Config.fontStyle,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                onPressed: Config.toPushPage(context, QuestionFormScreen()),
                icon: FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Config.onyxColor,
                ),
                label: const Text(
                  'เพิ่มคำถาม',
                  style: TextStyle(
                    fontFamily: Config.fontStyle,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _UserCard(String? userEmail, double progress, String status) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
    height: 80,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Config.antiFlashWhiteColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 20, top: 0, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 16,
                    color: Colors.green.shade300,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${userEmail}"),
                ],
              ),
              Text("Status : ${status}"),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: CircularPercentIndicator(
            radius: 27,
            lineWidth: 5,
            percent: progress,
            backgroundColor: Config.onyxColor,
            center: new Text("${(progress * 100).toInt()}%",
                style: TextStyle(color: Config.onyxColor, fontSize: 15)),
            progressColor: Config.earthYellowColor,
            animation: true,
            animationDuration: 300,
            animateFromLastPercent: true,
          ),
        )
      ],
    ),
  );
}
