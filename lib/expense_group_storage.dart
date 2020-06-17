import 'dart:convert';

import 'package:fluttershareexpense/expense_group.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseGroupStorage{

  static const String KEY_EXPENSE_GROUP_LIST = "KEY_EXPENSE_GROUP_LIST";

  static Future add(ExpenseGroup group) async {
    List<ExpenseGroup> list = await getAll();
    list.insert(0, group);
    await save(list);
  }

  static Future update(ExpenseGroup group) async {
    List<ExpenseGroup> list = await getAll();
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == group.id) {
        list[i] = group;
        break;
      }
    }
    await save(list);
  }

  static Future delete(ExpenseGroup debt) async {
    List<ExpenseGroup> list = await getAll();

    list.removeWhere((d) {
      return d.id == debt.id;
    });

    await save(list);
  }

  static Future save(List<ExpenseGroup> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonCodec jsonCodec = JsonCodec();
    String json = jsonCodec.encode(list);
    print(json);
    prefs.setString(KEY_EXPENSE_GROUP_LIST, json);
  }

  static Future<List<ExpenseGroup>> getAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString(KEY_EXPENSE_GROUP_LIST);

    List<ExpenseGroup> listDebt = List();
    if (str != null && str.isNotEmpty) {
      JsonCodec jsonCodec = JsonCodec();
      List listMap = jsonCodec.decode(str);
      listMap = listMap.map((map) {
        ExpenseGroup debt = ExpenseGroup.fromJson(map);
        return debt;
      }).toList();

      listDebt = listMap;
    }

    return listDebt;
  }

}