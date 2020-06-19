import 'package:flutter/material.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItemHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
              constraints: BoxConstraints(minWidth: 32),
              child: Text(
                MyLanguage.dictionary["number"],
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 1,
              child: Text(
                MyLanguage.dictionary["item_name"],
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                MyLanguage.dictionary["price_unit"],
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                MyLanguage.dictionary["amount"],
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                MyLanguage.dictionary["total"],
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            width: 44,
          ),
        ],
      ),
    );
  }
}
