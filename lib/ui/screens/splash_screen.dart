import 'package:flutter/material.dart';
import 'package:fluttershareexpense/hand_cursor.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:fluttershareexpense/my_application.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../my_theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange[100], Colors.orange[200],Colors.orange[100]], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/egg.png",
                    width: 300,
                  ),
                  Text(
                    MyApplication.APP_NAME,
                    style: GoogleFonts.mitr(fontSize: 50, color: Colors.white),
                  ),
                  Text(
                    MyLanguage.dictionary["app_caption"],
                    style: GoogleFonts.mitr(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(16)),
                    child: Container(
                      width: 400,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    MyLanguage.changeLanguage(MyLanguage.THAI);
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: MyApplication.currentLanguage == MyLanguage.THAI ? Colors.orange[400] : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ไทย",
                                          style: GoogleFonts.mitr(fontSize: 16, color: MyApplication.currentLanguage == MyLanguage.THAI ? Colors.white : Colors.grey[600]),
                                        ),
                                      ],
                                    )),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    MyLanguage.changeLanguage(MyLanguage.ENGLISH);
                                  });
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: MyApplication.currentLanguage == MyLanguage.ENGLISH ? Colors.orange[400] : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "English",
                                          style: GoogleFonts.mitr(fontSize: 16, color: MyApplication.currentLanguage == MyLanguage.ENGLISH ? Colors.white : Colors.grey[600]),
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "/home");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 80),
                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                Text(
                                  MyLanguage.dictionary["let_start"],
                                  style: GoogleFonts.mitr(fontSize: 28, color: Colors.white),
                                ),
                              ]),
                              decoration: BoxDecoration(color: Colors.yellow[700], borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Text(
                    "benzneststudios",
                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
