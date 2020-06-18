import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/ui/widgets/expense_mode_segmented_widget.dart';

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
  int deliverMode;
  int discountMode;

  ExpenseGroup(
      {this.id,
      this.title = "",
      this.deliver = 0,
      this.deliverMode = ExpenseMode.EQUAL,
      this.discountMode = ExpenseMode.EQUAL,
      this.discount = 0,
      this.listExpensePerson,
      this.onCalculationChanged}) {
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
      deliverMode: json["deliverMode"],
      discountMode: json["discountMode"],
      listExpensePerson: list.map((map) {
        var person = ExpensePerson.fromJson(map);
        person.init();
        return person;
      }).toList(),
    );

    print("list = ${group.listExpensePerson.length}");
    return group;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "title": this.title,
      "deliver": this.deliver,
      "deliverMode": this.deliverMode,
      "discount": this.discount,
      "discountMode": this.discountMode,
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

    double totalExpense = listExpensePerson.fold<double>(0, (previousValue, element) => previousValue + element.total);

    for (ExpensePerson person in listExpensePerson) {
      if (person.isPayDeliver) {
        if (deliverMode == ExpenseMode.EQUAL) {
          person.deliver = (deliver / countExpensePersonPayDelivery);
        } else {
          person.deliver = (person.total / totalExpense) * deliver;
        }
      } else {
        person.deliver = 0;
      }

      if (person.isGetDiscount) {
        if (discountMode == ExpenseMode.EQUAL) {
          person.discount = (discount / countExpensePersonGetDiscount);
        } else {
          person.discount = (person.total / totalExpense) * discount;
        }
      } else {
        person.discount = 0;
      }

      person.calculate();
    }
  }
}
