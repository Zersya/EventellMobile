import 'dart:async';
import 'package:bloc/bloc.dart';

import 'index.dart';

class DetaileventBloc extends Bloc<DetaileventEvent, DetaileventState> {
  static final DetaileventBloc _detaileventBlocSingleton = new DetaileventBloc._internal();
  factory DetaileventBloc() {
    return _detaileventBlocSingleton;
  }
  DetaileventBloc._internal();

  DetaileventState get initialState => new UnDetaileventState();

  @override
  Stream<DetaileventState> mapEventToState(
      DetaileventEvent event,
      ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('DetaileventBloc ' + _?.toString());
      yield currentState;
    }
  }
}
