import 'package:flutter/material.dart';
import 'package:fluttershareexpense/ui/widgets/my_checkbox.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_group.dart';
import 'my_text_field.dart';

class ExpenseItemTotalWidget extends StatelessWidget {
  final ExpenseGroup expenseGroup;
  final Function(ExpenseGroup) onChanged;

  ExpenseItemTotalWidget(this.expenseGroup,{this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Spacer(),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "รวมค่าอาหาร",
                    style: GoogleFonts.mitr(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseGroup.sumExpenseController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ]),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MyCheckBox(
                      value: expenseGroup.isPayDeliver,
                      color: Colors.pink[400],
                      onChanged: (v){
                        expenseGroup.isPayDeliver = v;
                        if(onChanged != null){
                          onChanged(expenseGroup);
                        }
                      },
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "จ่ายค่าส่ง",
                      style: GoogleFonts.mitr(fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  SizedBox(
                    height: 4,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseGroup.deliverGroupController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.pink()),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ]),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MyCheckBox(
                      value: expenseGroup.isGetDiscount,
                      color: Colors.orange[400],
                      onChanged: (v){
                        expenseGroup.isGetDiscount = v;
                        if(onChanged != null){
                          onChanged(expenseGroup);
                        }
                      },
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "ได้ส่วนลด",
                      style: GoogleFonts.mitr(fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  ]),
                  SizedBox(
                    height: 4,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseGroup.discountGroupController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.orange()),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ]),
                ],
              )),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "สุทธิ",
                    style: GoogleFonts.mitr(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseGroup.totalGroupController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.green()),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ]),
                ],
              )),
          Spacer(),
        ],
      ),
    );
  }
}
