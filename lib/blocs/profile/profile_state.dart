import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProfileState extends Equatable {
  ProfileState([Iterable props]) : super(props);

  /// Copy object for use in action
  ProfileState getStateCopy();
}

/// UnInitialized
class UnProfileState extends ProfileState {
  @override
  String toString() => 'UnProfileState';

  @override
  ProfileState getStateCopy() {
    return UnProfileState();
  }
}

/// Initialized
class InProfileState extends ProfileState {
  final FirebaseUser user;
  final avataaar;

  InProfileState(this.user, this.avataaar);

  @override
  String toString() => 'InProfileState';

  @override
  ProfileState getStateCopy() {
    return InProfileState(this.user, this.avataaar);
  }
}

class ErrorProfileState extends ProfileState {
  final String errorMessage;

  ErrorProfileState(this.errorMessage);
  
  @override
  String toString() => 'ErrorProfileState';

  @override
  ProfileState getStateCopy() {
    return ErrorProfileState(this.errorMessage);
  }
}

class LogoutedProfileState extends ProfileState {

  @override
  String toString() => 'LogoutedProfileState';

  @override
  ProfileState getStateCopy() {
    return LogoutedProfileState();
  }
}

class LoadingProfileState extends ProfileState {
   @override
  String toString() => 'LoadingProfileState';

  @override
  ProfileState getStateCopy() {
    return LoadingProfileState();
  }
}
