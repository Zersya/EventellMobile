import 'dart:async';
import 'package:bloc/bloc.dart';

import 'index.dart';

class MyTicketBloc extends Bloc<MyTicketEvent, MyTicketState> {
//  static final MyTicketBloc _myTicketBlocSingleton = new MyTicketBloc._internal();
//  factory MyTicketBloc() {
//    return _myTicketBlocSingleton;
//  }
//  MyTicketBloc._internal();

  MyTicketState get initialState => new UnMyTicketState();

  @override
  Stream<MyTicketState> mapEventToState(
      MyTicketEvent event,
      ) async* {
    if(event is LoadMyTicketEvent)
      yield LoadingMyTicketState();
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('MyTicketBloc ' + _?.toString());
      yield currentState;
    }
  }
}
