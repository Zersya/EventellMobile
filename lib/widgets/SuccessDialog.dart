import 'package:eventell/shared/utility.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final String word;

  const SuccessDialog({Key key, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: Coloring.colorMain,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 45,
              ),
              Text(
                word,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: Sizing.fontSuccessInfo,
                ),
              )
            ],
          ),
        ));
  }
}
