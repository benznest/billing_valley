import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_person.dart';

import 'expense_item_controller.dart';

class ExpenseGroup {
  int id;
  String title;
  TextEditingController deliverController;
  TextEditingController discountController;
  double deliver;
  double discount;
  List<ExpensePerson> listExpensePerson;
  OnCalculationDone onCalculationChanged;

  ExpenseGroup({this.id, this.title = "", this.deliver = 0, this.discount = 0, this.listExpensePerson,this.onCalculationChanged}) {
    id = id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
    init();
  }

  factory ExpenseGroup.fromJson(Map<String, dynamic> json) {
    print(json["listExpensePerson"]);
    List list = json["listExpensePerson"];
    print("list = ${list.length}");
    ExpenseGroup group = ExpenseGroup(
      id: json["id"],
      title: json["title"],
      deliver: json["deliver"],
      discount: json["discount"],
      listExpensePerson: list.map((map) => ExpensePerson.fromJson(map)).toList(),
    );

    print("list = ${group.listExpensePerson.length}");
    return group;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "deliver": this.deliver,
      "discount": this.discount,
      "listExpensePerson": this.listExpensePerson.map((e) => e.toJson()).toList(),
    };
  }

  init() {
    ExpensePerson expenseGroup = ExpensePerson(onCalculationChanged: onCalculationChanged);

    listExpensePerson = listExpensePerson ?? [expenseGroup];
    deliverController = TextEditingController(text: "");
    discountController = TextEditingController(text: "");
  }

  addExpensePerson() {
    ExpensePerson person = ExpensePerson(onCalculationChanged: onCalculationChanged);
    listExpensePerson.add(person);
    calculate();
  }

  deleteExpensePerson(int index) {
    listExpensePerson.removeAt(index);
    calculate();
  }

  calculate() {
    int countExpensePersonPayDelivery = listExpensePerson.where((e) => e.isPayDeliver).toList().length;
    int countExpensePersonGetDiscount = listExpensePerson.where((e) => e.isGetDiscount).toList().length;

    for (ExpensePerson person in listExpensePerson) {
      if (person.isPayDeliver) {
        person.deliver = (deliver / countExpensePersonPayDelivery);
      } else {
        person.deliver = 0;
      }

      if (person.isGetDiscount) {
        person.discount = (discount / countExpensePersonGetDiscount);
      } else {
        person.discount = 0;
      }

      person.calculate();
    }
  }
}
