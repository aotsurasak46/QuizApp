import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/quiz.dart';
import 'package:flutter_application_1/services/firebase_services.dart';
import 'package:flutter_application_1/services/user_service.dart';
import 'package:flutter_application_1/utils/config.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Config.alabasterColor,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                    color: Config.earthYellowColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ยืนยันตัวตนผ่านบริการของ Google",
                        style: TextStyle(
                          fontFamily: Config.fontStyle,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(100, 60),
                        ),
                        onPressed: () async {
                          var user =
                              await FirebaseServices().signInWithGoogle();
                          // bool isEmailExist =
                          //     await UserService().doesEmailExist(user.email);
                          if (user != null) {
                            UserService()
                                .storeUserData(user)
                                .whenComplete(() => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Quiz(),
                                        ),
                                      )
                                    });
                          }
                        },
                        child: Image.asset(
                          "assets/images/google-logo.png",
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Config.alabasterColor,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            TextButton.icon(
              onPressed: Config.toPopPage(context),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20.0,
                color: Colors.black,
              ),
              label: Text(
                'ย้อนกลับ',
                style: TextStyle(
                  fontFamily: Config.fontStyle,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
