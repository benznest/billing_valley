import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';
import 'package:fluttershareexpense/group_icon.dart';

class ExpenseGroup {
  String icon;
  double total = 0;
  double deliver = 0;
  double discount = 0;

  List<ExpenseItemController> listExpenseItemController;

  TextEditingController titleGroupController;
  TextEditingController sumExpenseController;
  TextEditingController deliverGroupController;
  TextEditingController discountGroupController;
  TextEditingController totalGroupController;

  OnCalculationDone onCalculationChanged;

  bool isPayDeliver;
  bool isGetDiscount;

  ExpenseGroup(
      {this.icon = GroupIcon.GIRL_1,
      this.deliver = 0,
      this.discount = 0,
      this.onCalculationChanged,
      this.isPayDeliver = true,
      this.isGetDiscount = true}) {
    init();
  }

  init() {
    var item = ExpenseItem();
    listExpenseItemController = [
      ExpenseItemController(item, onCalculateDone: () {
        calculate();
      })
    ];
    totalGroupController = TextEditingController(text: "-");
    deliverGroupController = TextEditingController(text: "-");
    discountGroupController = TextEditingController(text: "-");
    sumExpenseController = TextEditingController(text: "-");
    titleGroupController = TextEditingController(text: "");
  }

  String get titleGroup => titleGroupController.text;

  removeItem(int index) {
    listExpenseItemController.removeAt(index);
    calculate();
  }

  addItemEmpty() {
    listExpenseItemController
        .add(ExpenseItemController(ExpenseItem(), onCalculateDone: () {
      calculate();
    }));
  }

  calculate() {
    deliverGroupController.text = "${deliver.toString()}";
    discountGroupController.text = "${discount.toString()}";

    double sum = 0;
    for (ExpenseItemController item in listExpenseItemController) {
      sum += item.total;
    }

    sumExpenseController.text = "${sum.toString()}";

    total = sum + deliver - discount;
    totalGroupController.text = "${total.toString()}";
    if (onCalculationChanged != null) {
      onCalculationChanged();
    }
  }
}
