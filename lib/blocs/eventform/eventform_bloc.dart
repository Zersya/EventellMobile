import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eventell/blocs/eventform/index.dart';

class EventformBloc extends Bloc<EventformEvent, EventformState> {
  static final EventformBloc _eventformBlocSingleton = new EventformBloc._internal();
  factory EventformBloc() {
    return _eventformBlocSingleton;
  }
  EventformBloc._internal();
  
  EventformState get initialState => new UnEventformState();

  @override
  Stream<EventformState> mapEventToState(
    EventformEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('EventformBloc ' + _?.toString());
      yield currentState;
    }
  }
}
