import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LikesState extends Equatable {
  LikesState([Iterable props]) : super(props);

  /// Copy object for use in action
  LikesState getStateCopy();
}

/// UnInitialized
class UnLikesState extends LikesState {
  @override
  String toString() => 'UnLikesState';

  @override
  LikesState getStateCopy() {
    return UnLikesState();
  }
}

/// Initialized
class InLikesState extends LikesState {

  final Stream<DocumentSnapshot> streamCurrentUser;
  final Stream<QuerySnapshot> streamListEvent;

  InLikesState(this.streamCurrentUser, this.streamListEvent);

  @override
  String toString() => 'InLikesState';

  @override
  LikesState getStateCopy() {
    return InLikesState(this.streamCurrentUser, this.streamListEvent);
  }
}

class ErrorLikesState extends LikesState {
  final String errorMessage;

  ErrorLikesState(this.errorMessage);

  @override
  String toString() => 'ErrorLikesState';

  @override
  LikesState getStateCopy() {
    return ErrorLikesState(this.errorMessage);
  }
}

class LoadingLikesState extends LikesState {

  @override
  String toString() => 'LoadingLikesState  ';

  @override
  LikesState getStateCopy() {
    return LoadingLikesState  ();
  }
}
