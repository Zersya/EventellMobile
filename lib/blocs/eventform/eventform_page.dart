import 'package:flutter/material.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/Utils/utility.dart';

class EventformPage extends StatelessWidget {
  final dataEdit;

  const EventformPage({Key key, this.dataEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Coloring.colorMain,
        title: new Text("Create Event", style: TextStyle(color: Colors.black87),),
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
      ),
      body: new EventformScreen(dataEdit: dataEdit),
    );
  }
}
