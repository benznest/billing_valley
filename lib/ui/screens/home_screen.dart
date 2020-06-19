import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/hand_cursor.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:fluttershareexpense/my_application.dart';
import 'package:fluttershareexpense/screen_manager.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_group_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/group_form_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/my_about_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/summary_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/expense_mode_segmented_widget.dart';
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

    if (ScreenManager.get(context) == ScreenType.EXTRA_SMALL) {
      return Scaffold(
          body: Center(
              child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(MyLanguage.dictionary["sorry"], style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 36)),
          Text(MyLanguage.dictionary["not_support_this_screen_size"], style: GoogleFonts.mitr(color: Colors.grey[500], fontSize: 24)),
        ],
      )));
    }

    return Scaffold(
      body: Column(children: [
        buildNavBar(),
        Expanded(
            child: Stack(children: [
          ListView.builder(
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
              itemCount: expenseGroup.listExpensePerson.length + 1,
              itemBuilder: (context, index) {
                if (index < expenseGroup.listExpensePerson.length) {
                  return ExpensePersonWidget(
                    expensePerson: expenseGroup.listExpensePerson[index],
                    enableDeleteExpensePerson: expenseGroup.listExpensePerson.length > 1,
                    onChanged: () {
                      setState(() {
                        expenseGroup.calculate();
                      });
                    },
                    onDelete: () {
                      setState(() {
                        expenseGroup.deleteExpensePerson(index);
                      });
                    },
                  );
                } else {
                  return Column(
                    children: [
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
                                  MyLanguage.dictionary["add_person"],
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
                        height: 100,
                      ),
                    ],
                  );
                }
              }),
          SizedBox(
            height: 50,
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
          ),
          Container(
              margin: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      initGroup(ExpenseGroup());
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
                      child: Row(mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 36,
                            color: Colors.grey[600],
                          ),
                          Text(
                            MyLanguage.dictionary["clear"],
                            style: GoogleFonts.mitr(fontSize: 18, color: Colors.grey[600]),
                          ),
                        ],
                      )),
                ),
              )),
        ]))
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: HandCursor(
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xfff1c40f),
          elevation: 0,
          icon: Icon(Icons.check),
          label: Text(MyLanguage.dictionary["summary"], style: GoogleFonts.mitr(color: Colors.white, fontSize: 18)),
          onPressed: () {
            SummaryDialog.show(context, expenseGroup);
          },
        ),
      ),
    );
  }

  Widget buildDeliveryCostCard() {
    return MyCard(
        borderRadius: BorderRadius.circular(12),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/food_delivery.png",
                      width: 40,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      MyLanguage.dictionary["delivery_cost"],
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
//                    SizedBox(
//                      width: 8,
//                    ),
//                    Text(
//                      "บาท",
//                      style: GoogleFonts.mitr(fontSize: 20),
//                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                        width: 220,
                        child: ExpenseModeSegmentWidget(
                          initMode: expenseGroup.deliverMode,
                          onModeChanged: (mode) {
                            setState(() {
                              expenseGroup.deliverMode = mode;
                              expenseGroup.calculate();
                            });
                          },
                        ))
                  ],
                ),
              ),
            ],
          ),
        ]));
  }

  Widget buildDiscountCard() {
    return MyCard(
        borderRadius: BorderRadius.circular(12),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icons/sale.png",
                      width: 40,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      MyLanguage.dictionary["discount"],
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
//                    SizedBox(
//                      width: 8,
//                    ),
//                    Text(
//                      "บาท",
//                      style: GoogleFonts.mitr(fontSize: 20),
//                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                        width: 220,
                        child: ExpenseModeSegmentWidget(
                          initMode: expenseGroup.discountMode,
                          onModeChanged: (mode) {
                            setState(() {
                              expenseGroup.discountMode = mode;
                              expenseGroup.calculate();
                            });
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }

  Widget buildNavBar() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Colors.grey[100], width: 2))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  MyLanguage.dictionary["group"],
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
                            expenseGroup.title.isNotEmpty ? expenseGroup.title : MyLanguage.dictionary["unknown"],
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
                            MyLanguage.dictionary["create_group"],
                            style: GoogleFonts.mitr(fontSize: 18, color: Colors.pink[400]),
                          ),
                        ],
                      )),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      MyLanguage.changeLanguage(MyLanguage.THAI);
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      decoration:
                          BoxDecoration(color: MyApplication.currentLanguage == MyLanguage.THAI ? Colors.orange[400] : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
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
                          color: MyApplication.currentLanguage == MyLanguage.ENGLISH ? Colors.orange[400] : Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "English",
                            style: GoogleFonts.mitr(fontSize: 16, color: MyApplication.currentLanguage == MyLanguage.ENGLISH ? Colors.white : Colors.grey[600]),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              SizedBox(
                width: 32,
              ),
              Expanded(child: buildDeliveryCostCard()),
              SizedBox(
                width: 32,
              ),
              Expanded(child: buildDiscountCard()),
              SizedBox(
                width: 32,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
