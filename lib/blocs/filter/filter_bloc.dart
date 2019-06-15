import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';


class FilterBloc extends Bloc<FiltereventEvent, FiltereventState> {
//  static final FilterBloc _filterBlocSingleton = new FilterBloc._internal();
//  factory FilterBloc() {
//    return _filterBlocSingleton;
//  }
//  FilterBloc._internal();

  FiltereventState get initialState => new UnFiltereventState();

  @override
  Stream<FiltereventState> mapEventToState(
      FiltereventEvent event,
      ) async* {
    yield LoadingFiltereventState();
    try {
      yield await event.applyAsync(currentState: currentState, bloc: this);
    } catch (_) {
      print('FilterBloc ' + _?.toString());
      yield currentState;
    }
  }
}

@immutable
abstract class FiltereventEvent {
  Future<FiltereventState> applyAsync({FiltereventState currentState, FilterBloc bloc});
}

class LoadFiltereventEvent extends FiltereventEvent {

  final category, name;

  LoadFiltereventEvent({this.category, this.name});

  @override
  String toString() => 'LoadFiltereventEvent';

  @override
  Future<FiltereventState> applyAsync({FiltereventState currentState, FilterBloc bloc}) async {
    try {

      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();


      Stream<DocumentSnapshot> _streamCurrentUser = Firestore.instance
          .collection('users')
          .document(_user.email)
          .snapshots();
      Stream<DocumentSnapshot> _streamCategory = await Firestore.instance
          .collection('utility')
          .document('category')
          .snapshots();

      Stream<QuerySnapshot> _streamEvent;
      if(this.category != null) {
        _streamEvent = Firestore.instance.collection(
            "events")
            .where("eventCategory", isEqualTo: category)
            .snapshots();
      }
      else if(this.name != null){
        _streamEvent = Firestore.instance.collection(
            "events")
            .where("eventName", isEqualTo: this.name)
            .snapshots();
      }


      return new InFiltereventState(_streamEvent, _streamCurrentUser, _streamCategory );
    } catch (_) {
      print('LoadFiltereventEvent ' + _?.toString());
      return new ErrorFiltereventState(_?.toString());
    }
  }
}

@immutable
abstract class FiltereventState extends Equatable {
  FiltereventState([Iterable props]) : super(props);

  /// Copy object for use in action
  FiltereventState getStateCopy();
}

/// UnInitialized
class UnFiltereventState extends FiltereventState {
  @override
  String toString() => 'UnFiltereventState';

  @override
  FiltereventState getStateCopy() {
    return UnFiltereventState();
  }
}

/// Initialized
class InFiltereventState extends FiltereventState {

  final Stream<QuerySnapshot> streamEvent;
  final Stream<DocumentSnapshot> streamUser;
  final Stream<DocumentSnapshot> streamCategory ;

  InFiltereventState(this.streamEvent, this.streamUser, this.streamCategory );

  @override
  String toString() => 'InFiltereventState';

  @override
  FiltereventState getStateCopy() {
    return InFiltereventState(this.streamEvent, this.streamUser, this.streamCategory );
  }
}

class ErrorFiltereventState extends FiltereventState {
  final String errorMessage;

  ErrorFiltereventState(this.errorMessage);

  @override
  String toString() => 'ErrorFiltereventState';

  @override
  FiltereventState getStateCopy() {
    return ErrorFiltereventState(this.errorMessage);
  }
}

class LoadingFiltereventState extends FiltereventState {

  @override
  String toString() => 'LoadingFiltereventState  ';

  @override
  FiltereventState getStateCopy() {
    return LoadingFiltereventState  ();
  }
}

