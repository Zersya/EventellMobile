import 'dart:async';
import 'package:eventell/blocs/login/index.dart';
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
      // await Future.delayed(new Duration(seconds: 2));
      return new InProfileState();
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
