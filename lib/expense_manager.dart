import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';

class ExpenseManager {
  double deliver = 0;
  double discount = 0;
  double total = 0;

  List<ExpenseItemController> listExpenseItemController;

  TextEditingController deliverController;
  TextEditingController discountController;
  TextEditingController totalController;

  OnCalculationDone onCalculationChanged;

  ExpenseManager({this.onCalculationChanged}) {
    init();
  }

  init() {
    var item = ExpenseItem();
    listExpenseItemController = [
      ExpenseItemController(item, onCalculateDone: () {
        calculate();
      })
    ];
    deliverController = TextEditingController(text: "");
    discountController = TextEditingController(text: "");
    totalController = TextEditingController(text: "ไม่มีข้อมูล");
  }

  removeItem(int index) {
    listExpenseItemController.removeAt(index);
    calculate();
  }

  addItemEmpty() {
    listExpenseItemController.add(ExpenseItemController(ExpenseItem(), onCalculateDone: () {
      calculate();
    }));
  }

  calculate() {
    total = 0;
    for (ExpenseItemController item in listExpenseItemController) {
      total += item.total;
    }

    total = total + deliver - discount;
    totalController.text = "รวม ${total.toString()} บาท";
    if (onCalculationChanged != null) {
      onCalculationChanged();
    }
  }
}
