import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttershareexpense/expense_group_storage.dart';
import 'package:fluttershareexpense/expense_person.dart';
import 'package:fluttershareexpense/languages/my_language.dart';
import 'package:fluttershareexpense/person_icon.dart';
import 'package:fluttershareexpense/ui/dialogs/choose_icon_dialog.dart';
import 'package:fluttershareexpense/ui/widgets/my_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../expense_group.dart';
import '../widgets/my_card.dart';

class GroupPersonController {
  TextEditingController personNameController;
  String icon;

  GroupPersonController(
      {this.icon = PersonIcon.GIRL_1, String initTitle = ""}) {
    personNameController = TextEditingController();
    personNameController.text = initTitle;
  }
}

enum GroupFormDialogMode { CREATE, UPDATE }

class GroupFormDialog extends StatefulWidget {
  final GroupFormDialogMode mode;
  final ExpenseGroup initExpenseGroup;
  final Function(ExpenseGroup) onGroupPersonCreated;
  final Function(ExpenseGroup) onGroupPersonUpdated;

  GroupFormDialog(
      {this.mode = GroupFormDialogMode.CREATE,
      this.initExpenseGroup,
      this.onGroupPersonCreated,
      this.onGroupPersonUpdated});

  static showCreate(BuildContext context,
      {Function(ExpenseGroup) onGroupPersonCreated}) {
    showDialog(
        context: context,
        builder: (_) => GroupFormDialog(
            mode: GroupFormDialogMode.CREATE,
            onGroupPersonCreated: onGroupPersonCreated));
  }

  static showUpdate(BuildContext context, ExpenseGroup group,
      {Function(ExpenseGroup) onGroupPersonUpdated}) {
    showDialog(
        context: context,
        builder: (_) => GroupFormDialog(
            mode: GroupFormDialogMode.UPDATE,
            initExpenseGroup: group,
            onGroupPersonUpdated: onGroupPersonUpdated));
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
    if (widget.mode == GroupFormDialogMode.CREATE) {
      listGroupPersonController = [GroupPersonController()];
    } else {
      _groupTitleController.text = widget.initExpenseGroup.title;
      listGroupPersonController = [];
      for (ExpensePerson person in widget.initExpenseGroup.listExpensePerson) {
        listGroupPersonController.add(
            GroupPersonController(initTitle: person.title, icon: person.icon));
      }
    }

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
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    widget.mode == GroupFormDialogMode.CREATE
                        ? MyLanguage.dictionary["create_group"]
                        : MyLanguage.dictionary["edit_group"],
                    style: GoogleFonts.mitr(
                        color: Colors.grey[600], fontSize: 36)),
                SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(MyLanguage.dictionary["group_name"],
                        style: GoogleFonts.mitr(
                            color: Colors.grey[600], fontSize: 18)),
                    Row(
                      children: [
                        Expanded(
                            child: MyTextField.build(
                                controller: _groupTitleController,
                                fontSize: 22,
                                textAlign: TextAlign.center,
                                hintText: "..",
                                background: Colors.grey[100])),
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
                            return buildRowPerson(
                                listGroupPersonController[index],
                                enableRemove: listGroupPersonController.length >
                                    1, onIconSelected: (icon) {
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
                            label: Text(MyLanguage.dictionary["add_person"],
                                style: GoogleFonts.mitr(
                                    color: Colors.white, fontSize: 18)),
                            backgroundColor: Colors.purple[300],
                            onPressed: () {
                              setState(() {
                                listGroupPersonController
                                    .add(GroupPersonController());
                                scrollController.animateTo(
                                    scrollController.position.maxScrollExtent +
                                        100,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.mode == GroupFormDialogMode.CREATE
                                ? MyLanguage.dictionary["create"]
                                : MyLanguage.dictionary["save"],
                            style: GoogleFonts.mitr(
                                fontSize: 24, color: Colors.white),
                          ),
                        ]),
                    decoration: BoxDecoration(
                        color:  widget.mode == GroupFormDialogMode.CREATE
                            ? Colors.pink[300] : Colors.orange[300],
                        borderRadius: BorderRadius.circular(12)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  buildRowPerson(GroupPersonController groupPersonController,
      {bool enableRemove = true,
      Function() onRemove,
      Function(String) onIconSelected}) {
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
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[200], width: 1),
                      borderRadius: BorderRadius.circular(12)),
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
              child: MyTextField.build(
                  controller: groupPersonController.personNameController,
                  fontSize: 22,
                  textAlign: TextAlign.center,
                  hintText: MyLanguage.dictionary["name"],
                  background: Colors.white),
            ),
            SizedBox(
              width: 16,
            ),
            GestureDetector(
              onTap: () {
                if (enableRemove) {
                  if (onRemove != null) {
                    onRemove();
                  }
                }
              },
              child: Opacity(
                opacity: enableRemove ? 1 : 0.2,
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 32,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[200],
                      borderRadius: BorderRadius.circular(6)),
                ),
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
    ExpenseGroup group;
    if (widget.mode == GroupFormDialogMode.CREATE) {
      group = ExpenseGroup();
    }else{
      group = widget.initExpenseGroup;
    }

    String title = _groupTitleController.text;
    group.title = title;

    group.listExpensePerson = [];
    int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    for (GroupPersonController controller in listGroupPersonController) {
      group.listExpensePerson.add(ExpensePerson(
          id: id,
          title: controller.personNameController.text,
          icon: controller.icon));
      id++;
    }

    if (widget.mode == GroupFormDialogMode.CREATE) {
      await ExpenseGroupStorage.add(group);

      if (widget.onGroupPersonCreated != null) {
        widget.onGroupPersonCreated(group);
      }
    }else{
      await ExpenseGroupStorage.update(group);

      if (widget.onGroupPersonUpdated != null) {
        widget.onGroupPersonUpdated(group);
      }
    }
  }
}
