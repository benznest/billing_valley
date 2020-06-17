import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_icon_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_header_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_total_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_widget.dart';
import 'package:fluttershareexpense/ui/widgets/my_checkbox.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_card.dart';
import 'my_text_field.dart';

class ExpensePersonWidget extends StatelessWidget {
  final bool enableDeleteExpensePerson;
  final ExpensePerson expensePerson;
  final Function() onChanged;
  final Function() onDelete;

  ExpensePersonWidget(
      {@required this.expensePerson,
      this.onChanged,
      this.enableDeleteExpensePerson = true,
      this.onDelete});

  @override
  Widget build(BuildContext context) {
    return MyCard(
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(children: [
            GestureDetector(
              onTap: (){
                ChooseIconDialog.show(context,onIconSelected: (newIcon){
                  expensePerson.icon = newIcon;
                  update();
                });
              },
              child: Container(
                padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Image.asset(
                        PersonIcon.getAsset(expensePerson.icon),
                        width: 50,
                      ),
                      Icon(Icons.arrow_drop_down,size: 36,color: Colors.grey[500],)
                    ],
                  )),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "ชื่อ",
              style: GoogleFonts.mitr(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: MyTextField.build(
                    controller: expensePerson.titlePersonController,
                    fontSize: 22,
                    textAlign: TextAlign.center,
                    hintText: "..")),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (enableDeleteExpensePerson) {
                  if (onDelete != null) {
                    onDelete();
                  }
                }
              },
              child: Opacity(
                opacity: enableDeleteExpensePerson ? 1 : 0.3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      "ลบ",
                      style:
                          GoogleFonts.mitr(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ]),
                  decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 22,
          ),
          ExpenseItemHeaderWidget(),
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
          for (int i = 0; i < expensePerson.listExpenseItemController.length; i++)
            ExpenseItemWidget(i, expensePerson.listExpenseItemController[i],
                enableRemove: expensePerson.listExpenseItemController.length > 1,
                onPriceChanged: (controller, price) {
              controller.expenseItem.price = price;
              controller.calculate();
              update();
            }, onAmountChanged: (controller, amount) {
              controller.expenseItem.amount = amount;
              controller.calculate();
              update();
            }, onRemoveItem: () {
              expensePerson.removeItem(i);
            }),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              expensePerson.addItemEmpty();
              update();
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
              decoration: BoxDecoration(
                  color: Colors.green[300],
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
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
          ExpenseItemTotalWidget(expensePerson, onChanged: (g) {
            update();
          }),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }

  update() {
    if (onChanged != null) {
      onChanged();
    }
  }
}
