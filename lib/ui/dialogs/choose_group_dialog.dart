import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group_storage.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/screen_manager.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_icon_dialog.dart';
import 'package:fluttershareexpense/ui/dialogs/group_form_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_group.dart';
import '../widgets/my_card.dart';

class ChooseGroupDialog extends StatefulWidget {
  final Function(ExpenseGroup) onGroupPersonSelected;

  ChooseGroupDialog({this.onGroupPersonSelected});

  static show(BuildContext context, {Function(ExpenseGroup) onGroupPersonSelected}) {
    showDialog(context: context, builder: (_) => ChooseGroupDialog(onGroupPersonSelected: onGroupPersonSelected));
  }

  @override
  State<StatefulWidget> createState() {
    return ChooseGroupDialogState();
  }
}

class ChooseGroupDialogState extends State<ChooseGroupDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: ScreenManager.responsive(
              context,
              xs: width * 0.9,
              sm: width * 0.9,
              md: width * 0.9,
              lg: width * 0.7,
              xl: width *0.5,
              value: width * 0.7,
            ),
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(   MyLanguage.dictionary["choose_group"], style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 36)),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: FutureBuilder(
                      future: ExpenseGroupStorage.getAll(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ExpenseGroup> list = snapshot.data;
                          if (list.isNotEmpty) {
                            return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return buildRowGroup(list[index]);
                              },
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(   MyLanguage.dictionary["no_data"],
                                    style: GoogleFonts.mitr(fontSize: 28, color: Colors.grey[600]),
                                  ),
                                  Text(
                                    MyLanguage.dictionary["no_group_yet"],
                                    style: GoogleFonts.mitr(fontSize: 18, color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              snapshot.error.toString(),
                              style: GoogleFonts.mitr(fontSize: 16, color: Colors.red[400]),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget buildRowGroup(ExpenseGroup group) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      padding: EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(group.title.isNotEmpty ? group.title : MyLanguage.dictionary["unknown"], style: GoogleFonts.mitr(fontSize: 24, color: Colors.grey[600])),
                ),
                GestureDetector(
                  onTap: () {
                    GroupFormDialog.showUpdate(context, group, onGroupPersonUpdated: (group) {
                      setState(() {
                        //
                      });
                    });
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      Text(
                        MyLanguage.dictionary["edit"],
                        style: GoogleFonts.mitr(fontSize: 16, color: Colors.white),
                      ),
                    ]),
                    decoration: BoxDecoration(color: Colors.orange[300], borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    await ExpenseGroupStorage.delete(group);
                    setState(() {});
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      Text(
                        MyLanguage.dictionary["remove"],
                        style: GoogleFonts.mitr(fontSize: 16, color: Colors.white),
                      ),
                    ]),
                    decoration: BoxDecoration(color: Colors.red[300], borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    if (widget.onGroupPersonSelected != null) {
                      widget.onGroupPersonSelected(group);
                    }
                  },
                  child: Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                      Text(
                        MyLanguage.dictionary["select"],
                        style: GoogleFonts.mitr(fontSize: 16, color: Colors.white),
                      ),
                    ]),
                    decoration: BoxDecoration(color: Colors.green[300], borderRadius: BorderRadius.circular(12)),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (ExpensePerson person in group.listExpensePerson) buildPerson(person),
                    ],
                  ),
                ),
              ],
            ),
//            SizedBox(
//              height: 16,
//            ),
//            GestureDetector(
//              onTap: () {
//                Navigator.pop(context);
//              },
//              child: Container(
//                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
//                child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Text(
//                        "เลือก",
//                        style: GoogleFonts.mitr(
//                            fontSize: 24, color: Colors.white),
//                      ),
//                    ]),
//                decoration: BoxDecoration(
//                    color: Colors.pink[300],
//                    borderRadius: BorderRadius.circular(12)),
//              ),
//            )
          ],
        ),
      ),
    );
  }

  Widget buildPerson(ExpensePerson person) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(color: Colors.grey[50], border: Border.all(color: Colors.grey[200], width: 1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            PersonIcon.getAsset(person.icon),
            width: 60,
          ),
          SizedBox(
            height: 6,
          ),
          Text(person.title, style: GoogleFonts.mitr(fontSize: 14, color: Colors.grey[600]))
        ],
      ),
    );
  }
}
