import 'package:flutter/material.dart';
import 'package:fluttershareexpense/hand_cursor.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../my_theme.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffbdc3c7),
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
                    "หารค่าอาหาร",
                    style: GoogleFonts.mitr(fontSize: 50, color: Colors.white),
                  ),
                  Text(
                    "ขี้เกียจคิดเงินแชร์ค่าอาหารกับเพื่อนๆ ใช่ไหมล่ะ?",
                    style: GoogleFonts.mitr(fontSize: 22, color: Colors.white),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/home");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 6, horizontal: 80),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "เริ่มต้นใช้งาน",
                          style: GoogleFonts.mitr(
                              fontSize: 28, color: Colors.white),
                        ),
                      ]),
                      decoration: BoxDecoration(
                          color: Color(0xfff1c40f),
                          borderRadius: BorderRadius.circular(12)),
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
