import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';

typedef OnCalculationDone = Function();

class ExpenseItemController {
  ExpenseItem expenseItem;
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController amountController;
  TextEditingController sumController;

  TextEditingController deliverController;
  TextEditingController totalController;

  OnCalculationDone onCalculateDone;

  ExpenseItemController(ExpenseItem item, {this.onCalculateDone}) {
    expenseItem = item;
    nameController = TextEditingController(text: item.name);
    priceController = TextEditingController(text: item.price > 0 ? item.price.toString() : "");
    amountController = TextEditingController(text: item.amount.toString());
    sumController = TextEditingController(text: (item.amount * item.price).toString());

    deliverController = TextEditingController();
    totalController = TextEditingController();
  }

  decreaseAmount() {
    if (expenseItem.amount > 0) {
      expenseItem.amount--;
      amountController.text = expenseItem.amount.toString();
      calculate();
    }
  }

  increaseAmount() {
    expenseItem.amount++;
    amountController.text = expenseItem.amount.toString();
    calculate();
  }

  double get total => expenseItem.amount * expenseItem.price;

  calculate() {
    sumController.text = total.toString();
    if (onCalculateDone != null) {
      onCalculateDone();
    }
  }
}
