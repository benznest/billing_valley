import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseMode {
  static const EQUAL = 1;
  static const RATIO = 2;
}

class ExpenseModeSegmentWidget extends StatefulWidget {
  final int initMode;
  final Function(int) onModeChanged;

  ExpenseModeSegmentWidget({this.initMode = ExpenseMode.EQUAL, this.onModeChanged});

  @override
  _ExpenseModeSegmentWidgetState createState() => _ExpenseModeSegmentWidgetState();
}

class _ExpenseModeSegmentWidgetState extends State<ExpenseModeSegmentWidget> {
  int modeSelected;

  @override
  void initState() {
    modeSelected = widget.initMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            child: buildSegment(title: "หารเท่ากัน", mode: ExpenseMode.EQUAL),
          ),
          Expanded(
            child: buildSegment(title: "ตามสัดส่วน", mode: ExpenseMode.RATIO),
          ),
        ],
      ),
    );
  }

  Widget buildSegment({String title = "", int mode}) {
    bool selected = modeSelected == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          modeSelected = mode;
        });

        if (widget.onModeChanged != null) {
          widget.onModeChanged(modeSelected);
        }
      },
      child: Container(
          decoration: BoxDecoration(color: selected ? Colors.pink[300] : Colors.grey[200], borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.mitr(fontSize: 16, color: selected ? Colors.white : Colors.grey[600]),
            ),
          )),
    );
  }
}
