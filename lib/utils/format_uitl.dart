import 'package:intl/intl.dart';

class FormatUtil{

  static String value(num number){
    final formatter = new NumberFormat("###0.##");
    return formatter.format(number);
  }

  static String amount(num number){
    final formatter = new NumberFormat("#,##0.##");
    return formatter.format(number);
  }
  static String number(num number){
    final formatter = new NumberFormat("#,##0.00");
    return formatter.format(number);
  }
  static String number4point(num number){
    final formatter = new NumberFormat("#,##0.0000");
    return formatter.format(number);
  }

  static String count(num number){
    final formatter = new NumberFormat("#,###");
    return formatter.format(number);
  }
}