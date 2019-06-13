import 'dart:async';
import 'package:bloc/bloc.dart';

import 'index.dart';

class DetailmyticketBloc extends Bloc<DetailmyticketEvent, DetailmyticketState> {
//  static final DetailmyticketBloc _detailmyticketBlocSingleton = new DetailmyticketBloc._internal();
//  factory DetailmyticketBloc() {
//    return _detailmyticketBlocSingleton;
//  }
//  DetailmyticketBloc._internal();
//
  DetailmyticketState get initialState => new UnDetailmyticketState();

  @override
  Stream<DetailmyticketState> mapEventToState(
      DetailmyticketEvent event,
      ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('DetailmyticketBloc ' + _?.toString());
      yield currentState;
    }
  }
}
