
import 'package:flutter/material.dart';
import 'package:fluttershareexpense/my_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFieldTheme {
  Color background;
  Color borderColor;
  Color textColor;
  BoxBorder border;

  MyTextFieldTheme({this.background, this.borderColor, this.textColor});

  MyTextFieldTheme.greenStrong()
      : background = Colors.green[50],
        borderColor = Colors.green[400],
        textColor = Colors.grey[800],
        border = Border.all(color: Colors.green[400], width: 2);

  MyTextFieldTheme.green()
      : background = Colors.green[300].withOpacity(0.2),
        textColor = Colors.green[600];

  MyTextFieldTheme.general()
      : background = Colors.green[300].withOpacity(0.2),
        textColor = Colors.grey[800];

  MyTextFieldTheme.primary()
      : background = MyTheme.colorBackgroundPrimary1.withOpacity(0.1),
        textColor =  MyTheme.colorBackgroundPrimary1;


  MyTextFieldTheme.red()
      : background = Colors.red[300].withOpacity(0.2),
        textColor = Colors.red[600];

}

class MyTextField {
  static build(
      {String hintText = "",
        TextEditingController controller,
        TextAlign textAlign = TextAlign.start,
        double fontSize = 16,
        String fontFamily,
        bool readOnly = false,
        int maxLines,
        int minLines,
        int maxLength,
        Color background,
        Color textColor,
        BoxBorder border,
        Function(String) onChanged,
        MyTextFieldTheme theme,
        TextInputType keyboardType}) {

    if (theme != null) {
      background = background ?? theme.background;
      textColor = textColor ?? theme.textColor;
      border = border ?? theme.border;
    }

    return Container(
        decoration: BoxDecoration(color: background ?? Colors.grey[100], borderRadius: BorderRadius.circular(8), border: border),
        padding: EdgeInsets.all(8),
        child: TextField(
          controller: controller,
          readOnly: readOnly,
          minLines: minLines,
          maxLines: maxLines,
          textAlign: textAlign,
          maxLength: maxLength,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.all(0),
              hintText: hintText,
              hintStyle: GoogleFonts.mitr(fontSize: fontSize,color: Colors.grey[400])),
          style: GoogleFonts.mitr(color: textColor ?? Colors.grey[800], fontSize: fontSize),
        ));
  }
}