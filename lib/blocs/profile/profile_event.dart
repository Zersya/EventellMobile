import 'dart:async';
import 'package:eventell/blocs/profile/index.dart';
import 'package:meta/meta.dart';

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
      return new InProfileState();
    } catch (_) {
      print('LoadProfileEvent ' + _?.toString());
      return new ErrorProfileState(_?.toString());
    }
  }
}
