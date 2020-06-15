import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';
import 'package:fluttershareexpense/expense_manager.dart';
import 'package:fluttershareexpense/ui/widgets/my_card.dart';
import 'package:fluttershareexpense/ui/widgets/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share Bill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
//      appBar: AppBar(
//        centerTitle: true,
//        backgroundColor: Colors.white,
//        elevation: 2,
//        title: Text("คำนวณการแชร์บิลค่าอาหาร", style: GoogleFonts.mitr(color: Colors.grey[700])),
//      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 100),
        children: [
          MyCard(
              borderRadius: BorderRadius.circular(12),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
              ])),
          SizedBox(
            height: 32,
          ),
          MyCard(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildRowExpenseHeader(),
                SizedBox(
                  height: 4,
                ),
                Container(
                  height: 3,
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: 8,
                ),
                for (int i = 0; i < expenseManager.listExpenseItemController.length; i++)
                  buildRowExpense(i, expenseManager.listExpenseItemController[i], enableRemove: expenseManager.listExpenseItemController.length > 1, onRemoveItem: () {
                    expenseManager.removeItem(i);
                  }),
                SizedBox(
                  height: 8,
                ),
                buildRowExpenseTotal(),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 3,
                  color: Colors.grey[100],
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      expenseManager.addItemEmpty();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                      Text(
                        "เพิ่มรายการ",
                        style: GoogleFonts.mitr(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        width: 8,
                      )
                    ]),
                    decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildRowExpense(int index, ExpenseItemController expenseItemController, {bool enableRemove = true, Function() onRemoveItem}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
              constraints: BoxConstraints(minWidth: 32),
              child: Text(
                "${index + 1})",
                style: GoogleFonts.mitr(fontSize: 20),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: MyTextField.build(controller: expenseItemController.nameController, fontSize: 22, textAlign: TextAlign.center, hintText: "..")),
                  SizedBox(
                    width: 16,
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Row(children: [
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: MyTextField.build(
                      controller: expenseItemController.priceController,
                      fontSize: 22,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.numberWithOptions(
                        signed: false,
                        decimal: true,
                      ),
                      hintText: "0",
                      onChanged: (text) {
                        double price = double.tryParse(text) ?? 0;
                        setState(() {
                          expenseItemController.expenseItem.price = price;
                          expenseItemController.calculate();
                        });
                      })),
              SizedBox(
                width: 16,
              ),
            ]),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    expenseItemController.decreaseAmount();
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 32,
                    ),
                    decoration: BoxDecoration(color: Colors.orange[300], borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                    child: MyTextField.build(
                        controller: expenseItemController.amountController,
                        textAlign: TextAlign.center,
                        fontSize: 22,
                        onChanged: (text) {
                          int amount = double.tryParse(text) ?? 0;
                          setState(() {
                            expenseItemController.expenseItem.amount = amount;
                            expenseItemController.calculate();
                          });
                        })),
                SizedBox(
                  width: 6,
                ),
                GestureDetector(
                  onTap: () {
                    expenseItemController.increaseAmount();
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                    decoration: BoxDecoration(color: Colors.blue[300], borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: MyTextField.build(
                          controller: expenseItemController.sumController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.green())),
                  SizedBox(
                    width: 8,
                  ),
                ],
              )),
          if (enableRemove)
            GestureDetector(
              onTap: onRemoveItem,
              child: Container(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                ),
                decoration: BoxDecoration(color: Colors.red[300], borderRadius: BorderRadius.circular(6)),
              ),
            )
          else
            Container(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 32,
              ),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(6)),
            )
        ],
      ),
    );
  }

  Widget buildRowExpenseTotal() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(constraints: BoxConstraints(minWidth: 32)),
          Spacer(
            flex: 3,
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    "รวมค่าอาหาร",
                    style: GoogleFonts.mitr(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4,),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseManager.totalController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()),
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
                    "ค่าส่ง",
                    style: GoogleFonts.mitr(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4,),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseManager.totalController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()),
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
                  SizedBox(height: 4,),
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: MyTextField.build(
                          controller: expenseManager.totalController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary()),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ]),
                ],
              )),
          SizedBox(
            width: 44,
          ),
        ],
      ),
    );
  }

  Widget buildRowExpenseHeader() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
              constraints: BoxConstraints(minWidth: 32),
              child: Text(
                "ลำดับ",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.end,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "ชื่อรายการ",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "ราคาต่อหน่วย",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "จำนวน",
                style: GoogleFonts.mitr(fontSize: 16),
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 1,
              child: Text(
                "รวม",
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
