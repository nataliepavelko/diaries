import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final Icon icon;
  final Function()? function;
  MyFloatingActionButton(this.icon, this.function);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: icon,
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: function,
    );
  }
}
