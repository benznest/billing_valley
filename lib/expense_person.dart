import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_item.dart';
import 'package:fluttershareexpense/expense_item_controller.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/utils/format_uitl.dart';

class ExpensePerson {
  int id;
  String icon;
  String title;
  double total = 0;
  double deliver = 0;
  double discount = 0;

  List<ExpenseItemController> listExpenseItemController;

  TextEditingController titlePersonController;
  TextEditingController sumExpenseController;
  TextEditingController deliverPersonController;
  TextEditingController discountPersonController;
  TextEditingController totalPersonController;

  OnCalculationDone onCalculationChanged;

  bool isPayDeliver;
  bool isGetDiscount;

  ExpensePerson(
      {this.id,this.icon = PersonIcon.GIRL_1,this.title ="", this.total = 0, this.deliver = 0, this.discount = 0, this.onCalculationChanged, this.isPayDeliver = true, this.isGetDiscount = true}) {
    id = id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;
    init();
  }

  factory ExpensePerson.fromJson(Map<String, dynamic> json) {
    print("x");
    return ExpensePerson(
      id: json["id"],
      icon: json["icon"],
      title: json["title"],
      total:json["total"],
      deliver: json["deliver"],
      discount: json["discount"],
      isPayDeliver: json["isPayDeliver"],
      isGetDiscount: json["isGetDiscount"],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "icon": this.icon,
      "title": this.title,
      "total": this.total,
      "deliver": this.deliver,
      "discount": this.discount,
      "isPayDeliver": this.isPayDeliver,
      "isGetDiscount": this.isGetDiscount,
    };
  }

  init() {
    var item = ExpenseItem();
    listExpenseItemController = [
      ExpenseItemController(item, onCalculateDone: () {
        calculate();
      })
    ];
    totalPersonController = TextEditingController(text: "-");
    deliverPersonController = TextEditingController(text: "-");
    discountPersonController = TextEditingController(text: "-");
    sumExpenseController = TextEditingController(text: "-");
    titlePersonController = TextEditingController(text: "");
  }

  String get titlePerson => titlePersonController.text;

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
    deliverPersonController.text = FormatUtil.value(deliver);
    discountPersonController.text = FormatUtil.value(discount);

    double sum = 0;
    for (ExpenseItemController item in listExpenseItemController) {
      sum += item.total;
    }

    sumExpenseController.text = FormatUtil.value(sum);

    total = sum + deliver - discount;
    totalPersonController.text = FormatUtil.value(total);
    if (onCalculationChanged != null) {
      onCalculationChanged();
    }
  }
}
