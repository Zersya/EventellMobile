import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EventformState extends Equatable {
  EventformState([Iterable props]) : super(props);
  /// Copy object for use in action
  EventformState getStateCopy();
}

/// UnInitialized
class UnEventformState extends EventformState {
  @override
  String toString() => 'UnEventformState';

  @override
  EventformState getStateCopy() {
    return UnEventformState();
  }
}

/// Initialized
class InEventformState extends EventformState {
  final FirebaseUser user;
  final List<String> category;

  InEventformState(this.user, this.category);
  
  @override
  String toString() => 'InEventformState';

  @override
  EventformState getStateCopy() {
    return InEventformState(user, category);
  }
}

class ErrorEventformState extends EventformState {
  final String errorMessage;

  ErrorEventformState(this.errorMessage);
  
  @override
  String toString() => 'ErrorEventformState';

  @override
  EventformState getStateCopy() {
    return ErrorEventformState(this.errorMessage);
  }
}

class AddedState extends EventformState {
  @override
  String toString() => 'AddedState';

  @override
  AddedState getStateCopy() {
    return AddedState();
  }
}

class LoadingAddEventState extends EventformState {
  @override
  String toString() => 'LoadingAddEventState';

  @override
  LoadingAddEventState getStateCopy() {
    return LoadingAddEventState();
  }
}