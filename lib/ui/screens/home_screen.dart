import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/hand_cursor.dart';
import 'package:fluttershareexpense/screen_manager.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_group_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/group_form_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/my_about_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/summary_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/expense_person_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_header_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_total_widget.dart';
import 'package:fluttershareexpense/ui/widgets/my_card.dart';
import 'package:fluttershareexpense/ui/widgets/my_text_field.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_group.dart';
import '../../my_theme.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ExpenseGroup expenseGroup;

  @override
  void initState() {
    initGroup(ExpenseGroup());
    super.initState();
  }

  initGroup(ExpenseGroup group) {
    expenseGroup = group;
    expenseGroup.onCalculationChanged = () {
      setState(() {
        //
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
//      backgroundColor: Color(0xffecf0f1),
//      appBar: AppBar(
//        centerTitle: true,
//        backgroundColor: Color(0xffbdc3c7),
//        elevation: 0,
//        title: Text("หารค่าอาหาร",
//            style: GoogleFonts.mitr(color: Colors.white, fontSize: 20)),
//      ),
      body: Column(
        children: [
          buildChooseExpenseGroup(),
          Expanded(
            child: Stack(
              children: [
                ListView(
                  padding: EdgeInsets.symmetric(
                      vertical: 36,
                      horizontal: ScreenManager.responsive(
                        context,
                        xs: width * 0.05,
                        sm: width * 0.05,
                        md: width * 0.05,
                        lg: width * 0.05,
                        xl: width * 0.1,
                        value: width * 0.3,
                      )),
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    MyCard(
                        borderRadius: BorderRadius.circular(12),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/food_delivery.png",
                                      width: 60,
                                    ),
                                    SizedBox(
                                      width: 16,
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
                                            controller: expenseGroup.deliverController,
                                            fontSize: 22,
                                            textAlign: TextAlign.center,
                                            hintText: "0",
                                            onChanged: (text) {
                                              double deliver = double.tryParse(text) ?? 0;
                                              expenseGroup.deliver = deliver;
                                              expenseGroup.calculate();
                                            })),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "บาท",
                                      style: GoogleFonts.mitr(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/icons/sale.png",
                                      width: 60,
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
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
                                            controller: expenseGroup.discountController,
                                            fontSize: 22,
                                            textAlign: TextAlign.center,
                                            hintText: "0",
                                            onChanged: (text) {
                                              double discount = double.tryParse(text) ?? 0;
                                              expenseGroup.discount = discount;
                                              expenseGroup.calculate();
                                            })),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "บาท",
                                      style: GoogleFonts.mitr(fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "ค่าส่งและส่วนลดจะถูกหารเท่ากันทุกคน",
                            style: GoogleFonts.mitr(fontSize: 14, color: Colors.grey[400]),
                          ),
                        ])),
                    SizedBox(
                      height: 32,
                    ),
                    for (int i = 0; i < expenseGroup.listExpensePerson.length; i++)
                      ExpensePersonWidget(
                        expensePerson: expenseGroup.listExpensePerson[i],
                        enableDeleteExpensePerson: expenseGroup.listExpensePerson.length > 1,
                        onChanged: () {
                          setState(() {
                            expenseGroup.calculate();
                          });
                        },
                        onDelete: () {
                          expenseGroup.deleteExpensePerson(i);
                        },
                      ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            expenseGroup.addExpensePerson();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 120),
                            child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 36,
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "เพิ่มคน",
                                style: GoogleFonts.mitr(fontSize: 24, color: Colors.white),
                              ),
                              SizedBox(
                                width: 8,
                              )
                            ]),
                            decoration: BoxDecoration(color: Colors.purple[300], borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                          heroTag: "about",
                          child: Icon(
                            Icons.info,
                          ),
                          onPressed: () {
                            MyAboutDialog.show(context);
                          },
                          backgroundColor: Colors.blue[300])),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HandCursor(
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xfff1c40f),
          elevation: 0,
          icon: Icon(Icons.check),
          label: Text("สรุปผล", style: GoogleFonts.mitr(color: Colors.white, fontSize: 18)),
          onPressed: () {
            SummaryDialog.show(context, expenseGroup);
          },
        ),
      ),
    );
  }

  Widget buildChooseExpenseGroup() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[100], width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "กลุ่ม",
            style: GoogleFonts.mitr(fontSize: 20),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              ChooseGroupDialog.show(context, onGroupPersonSelected: (group) {
                setState(() {
                  initGroup(group);
                });
              });
            },
            child: Container(
                constraints: BoxConstraints(minWidth: 300),
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      expenseGroup.title.isNotEmpty ? expenseGroup.title : "ไม่มีกลุ่ม",
                      style: GoogleFonts.mitr(fontSize: 18),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 36,
                      color: Colors.grey[500],
                    )
                  ],
                )),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              GroupFormDialog.showCreate(context, onGroupPersonCreated: (group) {
                setState(() {
                  initGroup(group);
                });
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(color: Colors.pink[50], borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 36,
                      color: Colors.pink[400],
                    ),
                    Text(
                      "สร้างกลุ่ม",
                      style: GoogleFonts.mitr(fontSize: 18, color: Colors.pink[400]),
                    ),
                  ],
                )),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                initGroup(ExpenseGroup());
              });
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 36,
                      color: Colors.grey[600],
                    ),
                    Text(
                      "ล้างข้อมูล",
                      style: GoogleFonts.mitr(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
