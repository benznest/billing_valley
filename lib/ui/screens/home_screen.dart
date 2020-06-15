import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';
import 'package:fluttershareexpense/expense_group.dart';
import 'package:fluttershareexpense/ui/dialogs/summary_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/expense_group_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_header_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_total_widget.dart';
import 'package:fluttershareexpense/ui/widgets/my_card.dart';
import 'package:fluttershareexpense/ui/widgets/my_text_field.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_manager.dart';
import '../../my_theme.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExpenseManager expenseManager;

  @override
  void initState() {
    expenseManager = ExpenseManager(onCalculationChanged: () {
      setState(() {
        //
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xffecf0f1),
//      appBar: AppBar(
//        centerTitle: true,
//        backgroundColor: Color(0xffbdc3c7),
//        elevation: 0,
//        title: Text("หารค่าอาหาร",
//            style: GoogleFonts.mitr(color: Colors.white, fontSize: 20)),
//      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        children: [
          SizedBox(
            height: 16,
          ),
          MyCard(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          "ค่าส่ง",
                          style: GoogleFonts.mitr(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: MyTextField.build(
                                controller: expenseManager.deliverController,
                                fontSize: 22,
                                textAlign: TextAlign.center,
                                hintText: "0",
                                onChanged: (text) {
                                  double deliver = double.tryParse(text) ?? 0;
                                  expenseManager.deliver = deliver;
                                  expenseManager.calculate();
                                })),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "บาท",
                          style: GoogleFonts.mitr(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "ส่วนลด",
                          style: GoogleFonts.mitr(fontSize: 20),
                          textAlign: TextAlign.end,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: MyTextField.build(
                                controller: expenseManager.discountController,
                                fontSize: 22,
                                textAlign: TextAlign.center,
                                hintText: "0",
                                onChanged: (text) {
                                  double discount = double.tryParse(text) ?? 0;
                                  expenseManager.discount = discount;
                                  expenseManager.calculate();
                                })),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "บาท",
                          style: GoogleFonts.mitr(fontSize: 20),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                    SizedBox(height: 12,),
                    Text(
                      "ค่าส่งและส่วนลดจะถูกหารเท่ากันในทุกกลุ่ม",
                      style: GoogleFonts.mitr(fontSize: 14,color: Colors.grey[400]),
                    )
                  ])),
          SizedBox(
            height: 32,
          ),
          for (int i = 0; i < expenseManager.listExpenseGroup.length; i++)
            ExpenseGroupWidget(
              group: expenseManager.listExpenseGroup[i],
              enableDeleteGroup: expenseManager.listExpenseGroup.length > 1,
              onGroupChanged: () {
                setState(() {
                  //
                });
              },
              onDeleteGroup: () {
                expenseManager.deleteGroup(i);
              },
            ),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              expenseManager.addGroup();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 36,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      "เพิ่มกลุ่ม",
                      style:
                          GoogleFonts.mitr(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ]),
              decoration: BoxDecoration(
                  color: Colors.purple[300],
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xfff1c40f),
        elevation: 0,
        icon: Icon(Icons.check),
        label: Text("สรุปผล",
            style: GoogleFonts.mitr(color: Colors.white, fontSize: 18)),
        onPressed: () {
          SummaryDialog.show(context,expenseManager);
        },
      ),
    );
  }
}
