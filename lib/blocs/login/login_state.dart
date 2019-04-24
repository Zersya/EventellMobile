import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {
  LoginState([Iterable props]) : super(props);

  /// Copy object for use in action
  LoginState getStateCopy();
}

/// UnInitialized
class UnLoginState extends LoginState {
  @override
  String toString() => 'UnLoginState';

  @override
  LoginState getStateCopy() {
    return UnLoginState();
  }
}

/// Initialized
class InLoginState extends LoginState {
  @override
  String toString() => 'InLoginState';

  @override
  LoginState getStateCopy() {
    return InLoginState();
  }
}

class ErrorLoginState extends LoginState {
  final String errorMessage;

  ErrorLoginState(this.errorMessage);

  @override
  String toString() => 'ErrorLoginState';

  @override
  LoginState getStateCopy() {
    return ErrorLoginState(this.errorMessage);
  }
}

class LoadingLoginState extends LoginState {
  @override
  String toString() => 'LoadingLoginState';

  @override
  LoginState getStateCopy() {
    return LoadingLoginState();
  }
}

class SuccessLoginState extends LoginState {
  @override
  String toString() => 'SuccessLoginState';

  @override
  LoginState getStateCopy() {
    return SuccessLoginState();
  }
}
