import 'dart:async';
import 'package:eventell/blocs/register/index.dart';
import 'package:meta/meta.dart';

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
