import 'package:flutter/material.dart';

class CustomSmallButton extends StatelessWidget {
  final label;
  final color;
  final onPressed;
  final textColor;

  const CustomSmallButton({Key key, this.label, this.color, this.onPressed, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(label, style: TextStyle(color: textColor)),
      color: color,
      shape: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(30)),
      onPressed: onPressed,
    );
  }
}
