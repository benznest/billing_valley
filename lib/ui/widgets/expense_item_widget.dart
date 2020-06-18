import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_item_controller.dart';
import 'my_text_field.dart';

class ExpenseItemWidget extends StatelessWidget {
  final int index;
  final ExpenseItemController expenseItemController;
  final bool enableRemove;
  final Function() onRemoveItem;
  final Function(ExpenseItemController, double) onPriceChanged;
  final Function(ExpenseItemController, int) onAmountChanged;

  ExpenseItemWidget(this.index, this.expenseItemController, {this.enableRemove = true, this.onRemoveItem, this.onAmountChanged, this.onPriceChanged});

  @override
  Widget build(BuildContext context) {
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
                        if (onPriceChanged != null) {
                          onPriceChanged(expenseItemController, price);
                        }
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
                    if (onAmountChanged != null) {
                      onAmountChanged(expenseItemController, expenseItemController.expenseItem.amount);
                    }
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
                          if (onAmountChanged != null) {
                            onAmountChanged(expenseItemController, amount);
                          }
                        })),
                SizedBox(
                  width: 6,
                ),
                GestureDetector(
                  onTap: () {
                    expenseItemController.increaseAmount();
                    if (onAmountChanged != null) {
                      onAmountChanged(expenseItemController, expenseItemController.expenseItem.amount);
                    }
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
                          controller: expenseItemController.sumController, fontSize: 22, textAlign: TextAlign.center, readOnly: true, theme: MyTextFieldTheme.primary())),
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
}
