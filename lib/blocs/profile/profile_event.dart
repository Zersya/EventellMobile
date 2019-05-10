import 'dart:async';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:eventell/blocs/login/index.dart';
import 'package:eventell/blocs/myevent/myevent_bloc.dart';
import 'package:eventell/blocs/myevent/myevent_event.dart';
import 'package:eventell/blocs/myevent/myevent_state.dart';
import 'package:eventell/blocs/profile/index.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class ProfileEvent {
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc});
}

class LoadProfileEvent extends ProfileEvent {
  @override
  String toString() => 'LoadProfileEvent';

  @override
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc}) async {
    try {
      await Future.delayed(new Duration(seconds: 2));
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      var _avataaar =  Avataaar.random();

      return new InProfileState(_user, _avataaar);
    } catch (_) {
      print('LoadProfileEvent ' + _?.toString());
      return new ErrorProfileState(_?.toString());
    }
  }
}

class LogoutProfileEvent extends ProfileEvent {
  @override
  String toString() => 'LogoutProfileEvent';

  @override
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc}) async {
    try {
      Future.wait([FirebaseAuth.instance.signOut()]);
      LoginBloc().dispatch(LoadLoginEvent());
      MyeventBloc().dispatch(LogoutMyeventEvent());

      return new LogoutedProfileState();
    } catch (_) {
      print('LoadProfileEvent ' + _?.toString());
      return new ErrorProfileState(_?.toString());
    }
  }
}

class LoadingProfileEvent extends ProfileEvent {
  @override
  String toString() => 'LoadingProfileEvent';

  @override
  Future<ProfileState> applyAsync(
      {ProfileState currentState, ProfileBloc bloc}) async {
    try {
      return new LoadingProfileState();
    } catch (_) {
      print('LoadingProfileEvent ' + _?.toString());
      return new ErrorProfileState(_?.toString());
    }
  }
}
