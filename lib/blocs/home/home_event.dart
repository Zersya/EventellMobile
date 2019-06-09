import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/blocs/home/index.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

@immutable
abstract class HomeEvent {
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc});
}

class LoadHomeEvent extends HomeEvent {
  @override
  String toString() => 'LoadHomeEvent';

  @override
  Future<HomeState> applyAsync({HomeState currentState, HomeBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();

      Stream<QuerySnapshot> _streamListEvent = Firestore.instance
          .collection('events')
          .snapshots();

      Stream<QuerySnapshot> _streamRecomendedEvent = Firestore.instance
          .collection('events')
          .orderBy('eventLove', descending: true)
          .limit(3)
          .snapshots();

      Stream<DocumentSnapshot> _streamCurrentUser = Firestore.instance
          .collection('users')
          .document(_user.email)
          .snapshots();

      return new InHomeState(_user, _streamCurrentUser, _streamListEvent, _streamRecomendedEvent);
    } catch (_) {
      print('LoadHomeEvent ' + _?.toString());
      return new ErrorHomeState(_?.toString());
    }
  }
}
