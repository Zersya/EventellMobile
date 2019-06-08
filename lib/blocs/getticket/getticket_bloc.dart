import 'dart:async';
import 'package:bloc/bloc.dart';

import 'index.dart';

class GetTicketBloc extends Bloc<GetTicketEvent, GetTicketState> {
//  static final GetTicketBloc _getTicketBlocSingleton = new GetTicketBloc._internal();
//  factory GetTicketBloc() {
//    return _getTicketBlocSingleton;
//  }
//  GetTicketBloc._internal();

  GetTicketState get initialState => new UnGetTicketState();

  @override
  Stream<GetTicketState> mapEventToState(
      GetTicketEvent event,
      ) async* {
    if(event is SubmitTicketEvent)
      yield LoadingGetTicketState();
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('GetTicketBloc ' + _?.toString());
      yield currentState;
    }
  }
}
