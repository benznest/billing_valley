import 'package:flutter/material.dart';

class ExpenseItem{
  String name;
  double price;
  int amount;

  ExpenseItem({this.name="", this.price=0, this.amount=1});
}