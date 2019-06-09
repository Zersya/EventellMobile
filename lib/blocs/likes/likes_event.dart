import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class LikesEvent {
  Future<LikesState> applyAsync({LikesState currentState, LikesBloc bloc});
}

class LoadLikesEvent extends LikesEvent {
  
  @override
  String toString() => 'LoadLikesEvent';

  @override
  Future<LikesState> applyAsync({LikesState currentState, LikesBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();

      Stream<QuerySnapshot> _streamListEvent = Firestore.instance
          .collection('events')
          .where('eventLoved', arrayContains: _user.email)
          .snapshots();

      Stream<DocumentSnapshot> _streamCurrentUser = Firestore.instance
          .collection('users')
          .document(_user.email)
          .snapshots();


      return new InLikesState(_streamCurrentUser, _streamListEvent);
    } catch (_) {
      print('LoadLikesEvent ' + _?.toString());
      return new ErrorLikesState(_?.toString());
    }
  }
}
