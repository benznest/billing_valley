import 'package:flutter/material.dart';

class MyCheckBox extends StatefulWidget {
  final Color color;
  final bool value;
  final Function(bool) onChanged;

  MyCheckBox({this.value = false,this.color,this.onChanged});

  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(value){
      child= Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: widget.color ?? Colors.blue[400]),
        child: Icon(Icons.check,color: Colors.white,),
      );
    }else {
      child= Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: widget.color.withOpacity(0.5) ??Colors.grey[400], width: 4)),
      );
    }

    return GestureDetector(onTap: (){
      value = !value;
      setState(() {
       //
      });
      if(widget.onChanged != null){
        widget.onChanged(value);
      }
    },child: child);
  }
}
