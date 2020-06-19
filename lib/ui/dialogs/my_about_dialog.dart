import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/my_application.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../expense_group.dart';
import '../widgets/my_card.dart';

class MyAboutDialog extends StatelessWidget {
  MyAboutDialog();

  static show(BuildContext context) {
    showDialog(context: context, builder: (_) => MyAboutDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/egg.png",
                width: 100,
              ),
              Text(MyApplication.APP_NAME, style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 24)),
              Text("version ${MyApplication.VERSION}", style: GoogleFonts.mitr(color: Colors.grey[500], fontSize: 22)),
              SizedBox(
                height: 30,
              ),
              Text(
                MyLanguage.dictionary["developed_by"],
                style: GoogleFonts.mitr(color: Colors.grey[500], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              Text(
                MyApplication.DEVELOPER_NAME,
                style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                MyLanguage.dictionary["view_source_github"],
                style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 14),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                  onTap: () async {
                    final url = MyApplication.GITHUB_URL;
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  child: Text(
                    MyApplication.GITHUB_URL,
                    style: GoogleFonts.mitr(color: Colors.blue[300], fontSize: 12),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      MyLanguage.dictionary["close"],
                      style: GoogleFonts.mitr(fontSize: 24, color: Colors.white),
                    ),
                  ]),
                  decoration: BoxDecoration(color: Colors.pink[300], borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ));
  }
}
