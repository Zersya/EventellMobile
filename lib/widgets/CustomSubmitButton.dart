import 'package:flutter/material.dart';
import 'package:eventell/Utils/utility.dart';


class CustomSubmitButton extends StatefulWidget {
  final event;
  final String label;
  final IconData icon;
  const CustomSubmitButton({
    Key key, this.event, this.label, this.icon,

  }) : super(key: key);

  @override
  _CustomSubmitButtonState createState() => _CustomSubmitButtonState();
}

class _CustomSubmitButtonState extends State<CustomSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      shadowColor: Colors.black87,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: FlatButton.icon(
            color: Coloring.colorMain,
            icon: Icon(
              this.widget.icon,
              color: Coloring.colorLoginText,
            ),
            onPressed: this.widget.event,
            label: Text(
              this.widget.label,
              style: TextStyle(
                  color: Coloring.colorLoginText,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
