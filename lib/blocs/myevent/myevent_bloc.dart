import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eventell/blocs/myevent/index.dart';

class MyeventBloc extends Bloc<MyeventEvent, MyeventState> {
  static final MyeventBloc _myeventBlocSingleton = new MyeventBloc._internal();
  factory MyeventBloc() {
    return _myeventBlocSingleton;
  }
  MyeventBloc._internal();

  MyeventState get initialState => new UnMyeventState();

  @override
  Stream<MyeventState> mapEventToState(
    MyeventEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('MyeventBloc ' + _?.toString());
      yield currentState;
    }
  }
}
