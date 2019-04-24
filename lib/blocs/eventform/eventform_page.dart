import 'package:flutter/material.dart';
import 'package:eventell/blocs/eventform/index.dart';

class EventformPage extends StatelessWidget {
  static const String routeName = "/eventform";

  @override
  Widget build(BuildContext context) {
    var _eventformBloc = new EventformBloc();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Create Event"),
      ),
      body: new EventformScreen(eventformBloc: _eventformBloc),
    );
  }
}
