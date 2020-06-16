import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group.dart';
import 'package:fluttershareexpense/group_icon.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_icon_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_header_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_total_widget.dart';
import 'package:fluttershareexpense/ui/widgets/expense_item_widget.dart';
import 'package:fluttershareexpense/ui/widgets/my_checkbox.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_card.dart';
import 'my_text_field.dart';

class ExpenseGroupWidget extends StatelessWidget {
  final bool enableDeleteGroup;
  final ExpenseGroup group;
  final Function() onGroupChanged;
  final Function() onDeleteGroup;

  ExpenseGroupWidget(
      {@required this.group,
      this.onGroupChanged,
      this.enableDeleteGroup = true,
      this.onDeleteGroup});

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
                  group.icon = newIcon;
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
                        GroupIcon.getAsset(group.icon),
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
                    controller: group.titleGroupController,
                    fontSize: 22,
                    textAlign: TextAlign.center,
                    hintText: "..")),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (enableDeleteGroup) {
                  if (onDeleteGroup != null) {
                    onDeleteGroup();
                  }
                }
              },
              child: Opacity(
                opacity: enableDeleteGroup ? 1 : 0.3,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(
                      "ลบกลุ่ม",
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
          for (int i = 0; i < group.listExpenseItemController.length; i++)
            ExpenseItemWidget(i, group.listExpenseItemController[i],
                enableRemove: group.listExpenseItemController.length > 1,
                onPriceChanged: (controller, price) {
              controller.expenseItem.price = price;
              controller.calculate();
              update();
            }, onAmountChanged: (controller, amount) {
              controller.expenseItem.amount = amount;
              controller.calculate();
              update();
            }, onRemoveItem: () {
              group.removeItem(i);
            }),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              group.addItemEmpty();
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
          ExpenseItemTotalWidget(group, onChanged: (g) {
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
    if (onGroupChanged != null) {
      onGroupChanged();
    }
  }
}
