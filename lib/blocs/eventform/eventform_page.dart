import 'package:flutter/material.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/Utils/utility.dart';

class EventformPage extends StatelessWidget {
  static const String routeName = "/eventform";

  @override
  Widget build(BuildContext context) {
    var _eventformBloc = new EventformBloc();
    return new Scaffold(

      appBar: new AppBar(
        backgroundColor: Coloring.colorMain,
        title: new Text("Create Event", style: TextStyle(color: Colors.black87),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
      ),
      body: new EventformScreen(eventformBloc: _eventformBloc),
    );
  }
}
