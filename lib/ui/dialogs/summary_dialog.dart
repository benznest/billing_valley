import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_manager.dart';
import '../widgets/my_card.dart';

class SummaryDialog extends StatelessWidget {

  final ExpenseManager expenseManager;

  SummaryDialog(this.expenseManager);

  static show(BuildContext context,ExpenseManager expenseManager) {
    showDialog(context: context, builder: (_) => SummaryDialog(expenseManager));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          width: 500,
          height: MediaQuery.of(context).size.height*0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("สรุปผล",
                  style:
                      GoogleFonts.mitr(color: Colors.grey[600], fontSize: 36)),
              SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: expenseManager.listExpenseGroup.length,
                  itemBuilder: (context,index){
                    return buildRowSummary(index,expenseManager.listExpenseGroup[index]);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
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
                          "เสร็จสิ้น",
                          style: GoogleFonts.mitr(
                              fontSize: 24, color: Colors.white),
                        ),
                      ]),
                  decoration: BoxDecoration(
                      color: Color(0xff2c3e50),
                      borderRadius: BorderRadius.circular(12)),
                ),
              )
            ],
          ),
        ));
  }

  buildRowSummary(int index, ExpenseGroup expenseGroup) {
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
                "assets/icons/girl.png",
                width: 50,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(expenseGroup.titleGroup.isNotEmpty ? expenseGroup.titleGroup : "ไม่มีชื่อ",
                  style:
                      GoogleFonts.mitr(color: Colors.grey[600], fontSize: 20)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: Colors.red[300].withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Text("${expenseGroup.total}",
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
