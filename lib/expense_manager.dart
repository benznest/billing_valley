import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group.dart';

import 'expense_item_controller.dart';

class ExpenseManager {
  TextEditingController deliverController;
  TextEditingController discountController;
  double deliver;
  double discount;
  List<ExpenseGroup> listExpenseGroup;
  OnCalculationDone onCalculationChanged;

  ExpenseManager({this.deliver = 0, this.discount = 0, this.onCalculationChanged}) {
    init();
  }

  init() {
    ExpenseGroup expenseGroup = ExpenseGroup(onCalculationChanged: onCalculationChanged);

    listExpenseGroup = [expenseGroup];
    deliverController = TextEditingController(text: "");
    discountController = TextEditingController(text: "");
  }

  addGroup() {
    ExpenseGroup group = ExpenseGroup(onCalculationChanged: onCalculationChanged);
    listExpenseGroup.add(group);
    calculate();
  }

  deleteGroup(int index) {
    listExpenseGroup.removeAt(index);
    calculate();
  }

  calculate() {
    int countExpenseGroupPayDelivery = listExpenseGroup.where((e) => e.isPayDeliver).toList().length;
    int countExpenseGroupGetDiscount = listExpenseGroup.where((e) => e.isGetDiscount).toList().length;

    for (ExpenseGroup group in listExpenseGroup) {
      if (group.isPayDeliver) {
        group.deliver = (deliver / countExpenseGroupPayDelivery).ceilToDouble();
      } else {
        group.deliver = 0;
      }

      if (group.isGetDiscount) {
        group.discount = (discount / countExpenseGroupGetDiscount).ceilToDouble();
      } else {
        group.discount = 0;
      }

      group.calculate();
    }
  }
}
