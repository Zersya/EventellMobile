import 'dart:async';
import 'package:eventell/blocs/home/index.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync(
      {HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync(
      {HomeState currentState, HomeBloc bloc}) async {
    try {
      FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      FirebaseUser _user = await _firebaseAuth.currentUser();
      print(_user);
      return new InHomeState(_user);
    } catch (_) {
      print('LoadHomeEvent ' + _?.toString());
      return new ErrorHomeState(_?.toString());
    }
  }
}
