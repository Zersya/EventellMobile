import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:eventell/blocs/register/index.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  static final RegisterBloc _registerBlocSingleton = new RegisterBloc._internal();
  factory RegisterBloc() {
    return _registerBlocSingleton;
  }
  RegisterBloc._internal();
  
  RegisterState get initialState => new UnRegisterState();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('RegisterBloc ' + _?.toString());
      yield currentState;
    }
  }
}
