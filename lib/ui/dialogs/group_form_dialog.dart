import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group_storage.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_icon_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_group.dart';
import '../widgets/my_card.dart';

class GroupPersonController {
  TextEditingController personNameController;
  String icon;

  GroupPersonController({this.icon = PersonIcon.GIRL_1}) {
    personNameController = TextEditingController();
  }
}

class GroupFormDialog extends StatefulWidget {
  final Function(ExpenseGroup) onGroupPersonCreated;

  GroupFormDialog({this.onGroupPersonCreated});

  static show(BuildContext context, {Function(ExpenseGroup) onGroupPersonCreated}) {
    showDialog(context: context, builder: (_) => GroupFormDialog(onGroupPersonCreated: onGroupPersonCreated));
  }

  @override
  State<StatefulWidget> createState() {
    return GroupFormDialogState();
  }
}

class GroupFormDialogState extends State<GroupFormDialog> {
  ScrollController scrollController = ScrollController();
  List<GroupPersonController> listGroupPersonController;
  TextEditingController _groupTitleController = TextEditingController();

  @override
  void initState() {
    listGroupPersonController = [GroupPersonController()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 500,
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("สร้างกลุ่ม", style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 36)),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ชื่อกลุ่ม", style: GoogleFonts.mitr(color: Colors.grey[600], fontSize: 18)),
                    Row(
                      children: [
                        Expanded(
                            child: MyTextField.build(controller: _groupTitleController, fontSize: 22, textAlign: TextAlign.center, hintText: "..", background: Colors.grey[100])),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Stack(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.only(bottom: 100),
                          controller: scrollController,
                          itemCount: listGroupPersonController.length,
                          itemBuilder: (context, index) {
                            return buildRowPerson(listGroupPersonController[index], onIconSelected: (icon) {
                              setState(() {
                                listGroupPersonController[index].icon = icon;
                              });
                            }, onRemove: () {
                              setState(() {
                                listGroupPersonController.removeAt(index);
                              });
                            });
                          },
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: FloatingActionButton.extended(
                            icon: Icon(Icons.add),
                            label: Text("เพิ่มคน", style: GoogleFonts.mitr(color: Colors.white, fontSize: 18)),
                            backgroundColor: Colors.purple[300],
                            onPressed: () {
                              setState(() {
                                listGroupPersonController.add(GroupPersonController());
                                scrollController.animateTo(scrollController.position.maxScrollExtent + 100, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    save();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 32),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        "สร้าง",
                        style: GoogleFonts.mitr(fontSize: 24, color: Colors.white),
                      ),
                    ]),
                    decoration: BoxDecoration(color: Colors.pink[300], borderRadius: BorderRadius.circular(12)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  buildRowPerson(GroupPersonController groupPersonController, {Function() onRemove, Function(String) onIconSelected}) {
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
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                ChooseIconDialog.show(context, onIconSelected: (newIcon) {
                  if (onIconSelected != null) {
                    onIconSelected(newIcon);
                  }
                });
              },
              child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.grey[50], border: Border.all(color: Colors.grey[200], width: 1), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Image.asset(
                        PersonIcon.getAsset(groupPersonController.icon),
                        width: 50,
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: 36,
                        color: Colors.grey[500],
                      )
                    ],
                  )),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child:
                  MyTextField.build(controller: groupPersonController.personNameController, fontSize: 22, textAlign: TextAlign.center, hintText: "ชื่อ", background: Colors.white),
            ),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                if (onRemove != null) {
                  onRemove();
                }
              },
              child: Container(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 32,
                ),
                decoration: BoxDecoration(color: Colors.red[200], borderRadius: BorderRadius.circular(6)),
              ),
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
      ),
    );
  }

  save() async {
    ExpenseGroup group = ExpenseGroup();
    String title = _groupTitleController.text;
    group.title = title;

    for (GroupPersonController controller in listGroupPersonController) {
      group.listExpensePerson.add(ExpensePerson(title: controller.personNameController.text, icon: controller.icon));
    }

    await ExpenseGroupStorage.add(group);

    if (widget.onGroupPersonCreated != null) {
      widget.onGroupPersonCreated(group);
    }
  }
}
