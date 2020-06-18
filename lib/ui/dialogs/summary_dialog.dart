import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/ui/dialogs/group_form_dialog.dart';
import 'package:fluttershareexpense/utils/format_uitl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_group.dart';
import '../widgets/my_card.dart';

class SummaryDialog extends StatelessWidget {

  final ExpenseGroup expenseManager;

  SummaryDialog(this.expenseManager);

  static show(BuildContext context,ExpenseGroup expenseManager) {
    showDialog(context: context, builder: (_) => SummaryDialog(expenseManager));
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            width: 500,
            height: MediaQuery.of(context).size.height*0.6,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("สรุปผล",
                    style:
                        GoogleFonts.mitr(color: Colors.grey[600], fontSize: 36)),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: expenseManager.listExpensePerson.length,
                    itemBuilder: (context,index){
                      return buildRowSummary(index,expenseManager.listExpensePerson[index]);
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
//                GestureDetector(
//                  onTap: () {
////                  Navigator.pop(context);
//                  },
//                  child: Container(
//                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
//                    child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                            "สร้างกลุ่มใหม่",
//                            style: GoogleFonts.mitr(
//                                fontSize: 24, color: Colors.white),
//                          ),
//                        ]),
//                    decoration: BoxDecoration(
//                        color: Colors.blue[400],
//                        borderRadius: BorderRadius.circular(12)),
//                  ),
//                ),
//                SizedBox(
//                  height: 8,
//                ),
//                GestureDetector(
//                  onTap: () {
//                    Navigator.pop(context);
//                  },
//                  child: Container(
//                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
//                    child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: [
//                          Text(
//                            "บันทึกกลุ่ม",
//                            style: GoogleFonts.mitr(
//                                fontSize: 24, color: Colors.white),
//                          ),
//                        ]),
//                    decoration: BoxDecoration(
//                        color: Colors.pink[300],
//                        borderRadius: BorderRadius.circular(12)),
//                  ),
//                ),
//                SizedBox(
//                  height: 12,
//                ),
//                Container(height: 1,color: Colors.grey[200],),
//                SizedBox(
//                  height: 12,
//                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ปิด",
                            style: GoogleFonts.mitr(
                                fontSize: 24, color: Colors.white),
                          ),
                        ]),
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  buildRowSummary(int index, ExpensePerson expenseGroup) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Image.asset(
                PersonIcon.getAsset(expenseGroup.icon),
                width: 50,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(expenseGroup.titlePerson.isNotEmpty ? expenseGroup.titlePerson : "ไม่มีชื่อ",
                  style:
                      GoogleFonts.mitr(color: Colors.grey[600], fontSize: 20)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Text("${FormatUtil.value(expenseGroup.total)}",
                      style: GoogleFonts.mitr(
                          color: Colors.red[500], fontSize: 20)),
                  SizedBox(width: 6),
                  Text("บาท",
                      style: GoogleFonts.mitr(
                          color: Colors.red[500], fontSize: 14)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//  String getImageAsset(int index){
//    List<String> listAsset = ["breakfast","carbohydrates","food","meal","meat","sandwich"];
//    if(index < listAsset.length){
//      return listAsset[index];
//    }
//
//    return listAsset.last;
//  }
}
