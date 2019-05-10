import 'package:eventell/Utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:eventell/blocs/myevent/index.dart';

class MyeventPage extends StatelessWidget {
  static const String routeName = "/myevent";

  @override
  Widget build(BuildContext context) {
    var _myeventBloc = new MyeventBloc();
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Coloring.colorMain,
        title: new Text("My Event", style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
      ),
      body: new MyeventScreen(myeventBloc: _myeventBloc),
    );
  }
}
