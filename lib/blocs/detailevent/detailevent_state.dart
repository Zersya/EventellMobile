import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:eventell/shared/models/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetaileventState extends Equatable {
  DetaileventState([Iterable props]) : super(props);

  /// Copy object for use in action
  DetaileventState getStateCopy();
}

/// UnInitialized
class UnDetaileventState extends DetaileventState {
  @override
  String toString() => 'UnDetaileventState';

  @override
  DetaileventState getStateCopy() {
    return UnDetaileventState();
  }
}

/// Initialized
class InDetaileventState extends DetaileventState {

  final String email;

  InDetaileventState(this.email);

  @override
  String toString() => 'InDetaileventState';

  @override
  DetaileventState getStateCopy() {
    return InDetaileventState(this.email);
  }
}

class ErrorDetaileventState extends DetaileventState {
  final String errorMessage;

  ErrorDetaileventState(this.errorMessage);

  @override
  String toString() => 'ErrorDetaileventState';

  @override
  DetaileventState getStateCopy() {
    return ErrorDetaileventState(this.errorMessage);
  }
}

class LovedDetaileventState extends DetaileventState {

  final int eventLove;
  final List eventLoved;
  final bool isLoved;
  final User user;

  LovedDetaileventState(this.eventLove, this.eventLoved, this.isLoved, this.user);

  @override
  String toString() => 'LovedDetaileventState ';

  @override
  DetaileventState getStateCopy() {
    return LovedDetaileventState (this.eventLove, this.eventLoved, this.isLoved, this.user);
  }
}
