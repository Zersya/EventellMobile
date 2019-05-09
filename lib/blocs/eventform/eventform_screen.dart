import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eventell/blocs/eventform/pages/index.dart';

class EventformScreen extends StatefulWidget {
  const EventformScreen({
    Key key,
    @required EventformBloc eventformBloc,
  })  : _eventformBloc = eventformBloc,
        super(key: key);

  final EventformBloc _eventformBloc;

  @override
  EventformScreenState createState() {
    return new EventformScreenState(_eventformBloc);
  }
}

class EventformScreenState extends State<EventformScreen> {
  final EventformBloc _eventformBloc;
  EventformScreenState(this._eventformBloc);

  PageController _pageController = PageController(initialPage: 0);
  

  @override
  void initState() {
    super.initState();
    this._eventformBloc.dispatch(LoadEventformEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventformEvent, EventformState>(
        bloc: widget._eventformBloc,
        builder: (
          BuildContext context,
          EventformState currentState,
        ) {
          if (currentState is UnEventformState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorEventformState) {
            return new Container(
                child: new Center(
              child: new Text(currentState.errorMessage ?? 'Error'),
            ));
          }

          return ScreenForm(pageController: _pageController);
        });
  }
}

