import 'dart:async';
import 'package:eventell/blocs/login/index.dart';
import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class LoginEvent {
  Future<LoginState> applyAsync({LoginState currentState, LoginBloc bloc});
}

class LoadLoginEvent extends LoginEvent {
  @override
  String toString() => 'LoadLoginEvent';

  @override
  Future<LoginState> applyAsync(
      {LoginState currentState, LoginBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      var currentUser = await _auth.currentUser();
      if (currentUser != null) return new SuccessLoginState();

      return new InLoginState();
    } catch (_) {
      print('LoadLoginEvent ' + _?.toString());
      return new ErrorLoginState(_?.toString());
    }
  }
}

class SubmitLoginEvent extends LoginEvent {
  final String _email, _password;

  SubmitLoginEvent(this._email, this._password);

  @override
  String toString() => 'SubmitLoginEvent';

  @override
  Future<LoginState> applyAsync(
      {LoginState currentState, LoginBloc bloc}) async {
    try {
      FirebaseUser _user = await _login();
      return new SuccessLoginState();
    } catch (err) {
      return new ErrorLoginState(err.message);
    }
  }

  _login() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _user = await _auth.signInWithEmailAndPassword(
        email: _email, password: _password);

    return _user;
  }
}
