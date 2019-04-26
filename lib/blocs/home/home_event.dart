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
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      if(_user != null)
        return new InHomeState(_user);
      else{
        
      }
    } catch (_) {
      print('LoadHomeEvent ' + _?.toString());
      return new ErrorHomeState(_?.toString());
    }
  }
}
