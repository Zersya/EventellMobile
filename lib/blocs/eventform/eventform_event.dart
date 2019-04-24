import 'dart:async';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EventformEvent {
  Future<EventformState> applyAsync(
      {EventformState currentState, EventformBloc bloc});
}

class LoadEventformEvent extends EventformEvent {
  @override
  String toString() => 'LoadEventformEvent';

  @override
  Future<EventformState> applyAsync(
      {EventformState currentState, EventformBloc bloc}) async {
    try {
      await Future.delayed(new Duration(seconds: 2));
      return new InEventformState();
    } catch (_) {
      print('LoadEventformEvent ' + _?.toString());
      return new ErrorEventformState(_?.toString());
    }
  }
}
