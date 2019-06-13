import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DetailmyticketState extends Equatable {
  DetailmyticketState([Iterable props]) : super(props);

  /// Copy object for use in action
  DetailmyticketState getStateCopy();
}

/// UnInitialized
class UnDetailmyticketState extends DetailmyticketState {
  @override
  String toString() => 'UnDetailmyticketState';

  @override
  DetailmyticketState getStateCopy() {
    return UnDetailmyticketState();
  }
}

/// Initialized
class InDetailmyticketState extends DetailmyticketState {
  final Stream<QuerySnapshot> streamTicket;

  InDetailmyticketState(this.streamTicket);

  @override
  String toString() => 'InDetailmyticketState';

  @override
  DetailmyticketState getStateCopy() {
    return InDetailmyticketState(this.streamTicket);
  }
}

class ErrorDetailmyticketState extends DetailmyticketState {
  final String errorMessage;

  ErrorDetailmyticketState(this.errorMessage);

  @override
  String toString() => 'ErrorDetailmyticketState';

  @override
  DetailmyticketState getStateCopy() {
    return ErrorDetailmyticketState(this.errorMessage);
  }
}
