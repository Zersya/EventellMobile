import 'dart:async';
import 'package:bloc/bloc.dart';

import 'index.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
//  static final LikesBloc _likesBlocSingleton = new LikesBloc._internal();
//  factory LikesBloc() {
//    return _likesBlocSingleton;
//  }
//  LikesBloc._internal();

  LikesState get initialState => new UnLikesState();

  @override
  Stream<LikesState> mapEventToState(
      LikesEvent event,
      ) async* {
    yield LoadingLikesState();
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('LikesBloc ' + _?.toString());
      yield currentState;
    }
  }
}
