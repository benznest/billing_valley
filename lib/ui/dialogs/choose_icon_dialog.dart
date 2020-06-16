import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group.dart';
import 'package:fluttershareexpense/group_icon.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_manager.dart';
import '../widgets/my_card.dart';

class ChooseIconDialog extends StatelessWidget {
  final Function(String) onIconSelected;

  ChooseIconDialog({this.onIconSelected});

  static show(BuildContext context, {Function(String) onIconSelected}) {
    showDialog(
        context: context,
        builder: (_) => ChooseIconDialog(onIconSelected: onIconSelected));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              for (String id in GroupIcon.groupIcons)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    if (onIconSelected != null) {
                      onIconSelected(id);
                    }
                  },
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Image.asset(
                        GroupIcon.getAsset(id),
                        width: 80,
                      )),
                ),
            ],
          ),
        ));
  }
}
