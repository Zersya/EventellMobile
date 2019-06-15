
import 'package:eventell/shared/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleButtonCategory extends StatelessWidget {
  final name;
  final icon;
  final onTap;
  const CircleButtonCategory({Key key, this.name, this.icon, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(Sizing.circleCategorySizePadd),
        child: Column(
          children: <Widget>[
            Container(
              width: Sizing.circleCategorySize,
              height: Sizing.circleCategorySize,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text(this.name[0], style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),))
            ),
            Text(this.name)
          ],
        ),
      ),
    );
  }
}
