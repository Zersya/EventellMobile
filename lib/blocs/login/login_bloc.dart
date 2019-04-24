import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eventell/blocs/login/index.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  static final LoginBloc _loginBlocSingleton = new LoginBloc._internal();
  factory LoginBloc() {
    return _loginBlocSingleton;
  }
  LoginBloc._internal();
  
  LoginState get initialState => new UnLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoadingLoginState();
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('LoginBloc ' + _?.toString());
      yield currentState;
    }
  }
}
