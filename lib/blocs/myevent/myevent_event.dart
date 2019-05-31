import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/blocs/myevent/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MyeventEvent {
  Future<MyeventState> applyAsync(
      {MyeventState currentState, MyeventBloc bloc});
}

class LoadMyeventEvent extends MyeventEvent {
  @override
  String toString() => 'LoadMyeventEvent';

  @override
  Future<MyeventState> applyAsync(
      {MyeventState currentState, MyeventBloc bloc}) async {
    try {
      await Future.delayed(new Duration(seconds: 2));
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      print(_user.email);
      Stream<QuerySnapshot> _stream = Firestore.instance
          .collection('events')
          .where('createdBy', isEqualTo: _user.email)
          .snapshots();
      return new InMyeventState(_stream);
    } catch (_) {
      print('LoadMyeventEvent ' + _?.toString());
      return new ErrorMyeventState(_?.toString());
    }
  }
}

class LogoutMyeventEvent extends MyeventEvent {
  @override
  Future<MyeventState> applyAsync(
      {MyeventState currentState, MyeventBloc bloc}) async{
    return new UnMyeventState();
  }

  @override
  String toString() {
    return 'LogoutMyeventEvent';
  }
}
