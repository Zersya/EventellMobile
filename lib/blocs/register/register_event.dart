import 'dart:async';
import 'package:eventell/blocs/register/index.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class RegisterEvent {
  Future<RegisterState> applyAsync(
      {RegisterState currentState, RegisterBloc bloc});
}

class LoadRegisterEvent extends RegisterEvent {
  @override
  String toString() => 'LoadRegisterEvent';

  @override
  Future<RegisterState> applyAsync(
      {RegisterState currentState, RegisterBloc bloc}) async {
    try {
      await Future.delayed(new Duration(seconds: 2));
      return new InRegisterState();
    } catch (_) {
      print('LoadRegisterEvent ' + _?.toString());
      return new ErrorRegisterState(_?.toString());
    }
  }
}

class SubmitRegisterEvent extends RegisterEvent {
  final String _email, _password;

  SubmitRegisterEvent(this._email, this._password);

  @override
  String toString() => 'SubmitRegisterEvent';

  @override
  Future<RegisterState> applyAsync(
      {RegisterState currentState, RegisterBloc bloc}) async {
    try {
      await _register();
      return new SuccessRegisterState('Sukses membuat akun');
    } catch (err) {
      return new ErrorRegisterState(err.message);
    }
  }

  _register() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser _user = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return _user;
  }
}
