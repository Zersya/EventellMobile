import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyTicketState extends Equatable {
  MyTicketState([Iterable props]) : super(props);

  /// Copy object for use in action
  MyTicketState getStateCopy();
}

/// UnInitialized
class UnMyTicketState extends MyTicketState {
  @override
  String toString() => 'UnMyTicketState';

  @override
  MyTicketState getStateCopy() {
    return UnMyTicketState();
  }
}

/// Initialized
class InMyTicketState extends MyTicketState {

  final Stream<QuerySnapshot> streamTransactionEvent;
  final Stream<DocumentSnapshot> streamUser;

  InMyTicketState(this.streamTransactionEvent, this.streamUser);

  @override
  String toString() => 'InMyTicketState';

  @override
  MyTicketState getStateCopy() {
    return InMyTicketState(this.streamTransactionEvent, this.streamUser);
  }
}

class ErrorMyTicketState extends MyTicketState {
  final String errorMessage;

  ErrorMyTicketState(this.errorMessage);

  @override
  String toString() => 'ErrorMyTicketState';

  @override
  MyTicketState getStateCopy() {
    return ErrorMyTicketState(this.errorMessage);
  }
}

class LoadingMyTicketState extends MyTicketState {

  @override
  String toString() => 'LoadingMyTicketState  ';

  @override
  MyTicketState getStateCopy() {
    return LoadingMyTicketState  ();
  }
}
