import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group.dart';

import 'expense_item_controller.dart';

class ExpenseManager{
  TextEditingController deliverController;
  TextEditingController discountController;
  double deliver;
  double discount;
  List<ExpenseGroup> listExpenseGroup;
  OnCalculationDone onCalculationChanged;


  ExpenseManager({this.deliver=0,
      this.discount=0, this.onCalculationChanged}){
    init();
  }

  init() {
    ExpenseGroup expenseGroup = ExpenseGroup(onCalculationChanged: onCalculationChanged);

    listExpenseGroup = [expenseGroup];
    deliverController = TextEditingController(text: "");
    discountController = TextEditingController(text: "");
  }

  addGroup(){
    ExpenseGroup group = ExpenseGroup(onCalculationChanged: onCalculationChanged);
    listExpenseGroup.add(group);
    calculate();
  }

  deleteGroup(int index){
    listExpenseGroup.removeAt(index);
    calculate();
  }

  calculate(){
    for(ExpenseGroup group in listExpenseGroup){
      group.deliver = (deliver / listExpenseGroup.length).ceilToDouble();
      group.discount = (discount / listExpenseGroup.length).ceilToDouble();
      group.calculate();
    }
  }
}