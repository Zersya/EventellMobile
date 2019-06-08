import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GetTicketState extends Equatable {
  GetTicketState([Iterable props]) : super(props);

  /// Copy object for use in action
  GetTicketState getStateCopy();
}

/// UnInitialized
class UnGetTicketState extends GetTicketState {
  @override
  String toString() => 'UnGetTicketState';

  @override
  GetTicketState getStateCopy() {
    return UnGetTicketState();
  }
}

/// Initialized
class InGetTicketState extends GetTicketState {

  @override
  String toString() => 'InGetTicketState';

  @override
  GetTicketState getStateCopy() {
    return InGetTicketState();
  }
}

class ErrorGetTicketState extends GetTicketState {
  final String errorMessage;

  ErrorGetTicketState(this.errorMessage);

  @override
  String toString() => 'ErrorGetTicketState';

  @override
  GetTicketState getStateCopy() {
    return ErrorGetTicketState(this.errorMessage);
  }
}

class LoadingGetTicketState extends GetTicketState {

  @override
  String toString() => 'LoadingGetTicketState  ';

  @override
  GetTicketState getStateCopy() {
    return LoadingGetTicketState  ();
  }
}

class SubmittedGetTicketState extends GetTicketState {

  @override
  String toString() => 'SubmittedGetTicketState ';

  @override
  GetTicketState getStateCopy() {
    return SubmittedGetTicketState ();
  }
}
