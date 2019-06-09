import 'package:flutter/material.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/shared/utility.dart';

class EventformPage extends StatelessWidget {
  final dataEdit;

  const EventformPage({Key key, this.dataEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Coloring.colorMain,
        title: dataEdit != null ? _textAppBar('Edit Event') : _textAppBar('Create Event'),
        iconTheme: IconThemeData(
          color: Colors.black87
        ),
      ),
      body: new EventformScreen(dataEdit: dataEdit),
    );
  }

  Widget _textAppBar(text) => new Text(text, style: TextStyle(color: Colors.black87),);
}
