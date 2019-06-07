import 'dart:async';
import 'package:eventell/blocs/detailevent/detailevent_state.dart';
import 'package:meta/meta.dart';

import 'index.dart';

@immutable
abstract class DetaileventEvent {
  Future<DetaileventState> applyAsync({DetaileventState currentState, DetaileventBloc bloc});
}

class LoadDetaileventEvent extends DetaileventEvent {
  @override
  String toString() => 'LoadDetaileventEvent';

  @override
  Future<DetaileventState> applyAsync({DetaileventState currentState, DetaileventBloc bloc}) async {
    try {
      

      return new InDetaileventState();
    } catch (_) {
      print('LoadDetaileventEvent ' + _?.toString());
      return new ErrorDetaileventState(_?.toString());
    }
  }
}
