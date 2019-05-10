import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyeventState extends Equatable {
  MyeventState([Iterable props]) : super(props);

  /// Copy object for use in action
  MyeventState getStateCopy();
}

/// UnInitialized
class UnMyeventState extends MyeventState {
  @override
  String toString() => 'UnMyeventState';

  @override
  MyeventState getStateCopy() {
    return UnMyeventState();
  }
}

/// Initialized
class InMyeventState extends MyeventState {
  final Stream<QuerySnapshot> stream;

  InMyeventState(this.stream);

  @override
  String toString() => 'InMyeventState';

  @override
  MyeventState getStateCopy() {
    return InMyeventState(this.stream);
  }
}

class ErrorMyeventState extends MyeventState {
  final String errorMessage;

  ErrorMyeventState(this.errorMessage);
  
  @override
  String toString() => 'ErrorMyeventState';

  @override
  MyeventState getStateCopy() {
    return ErrorMyeventState(this.errorMessage);
  }
}
