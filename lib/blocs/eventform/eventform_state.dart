import 'package:equatable/equatable.dart';
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
  @override
  String toString() => 'InEventformState';

  @override
  EventformState getStateCopy() {
    return InEventformState();
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
