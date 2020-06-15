import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;

  MyCard({this.child, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: borderRadius, color: Colors.white, boxShadow: [BoxShadow(color: Colors.grey[300], spreadRadius: 1, blurRadius: 12)]),
      child: child,
    );
  }
}
