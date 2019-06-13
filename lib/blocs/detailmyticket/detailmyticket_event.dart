import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'index.dart';

@immutable
abstract class DetailmyticketEvent {
  Future<DetailmyticketState> applyAsync(
      {DetailmyticketState currentState, DetailmyticketBloc bloc});
}

class LoadDetailmyticketEvent extends DetailmyticketEvent {
  final String transactionId;

  LoadDetailmyticketEvent(this.transactionId);
  @override
  String toString() => 'LoadDetailmyticketEvent';

  @override
  Future<DetailmyticketState> applyAsync(
      {DetailmyticketState currentState, DetailmyticketBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      print("called");

      Stream<QuerySnapshot> _streamTicket = Firestore.instance
            .collection("users").document(_user.email)
            .collection("transactionTicket").document(transactionId)
            .collection("ticket")
            .snapshots();


      return new InDetailmyticketState(_streamTicket);

    } catch (_) {
      print('LoadDetailmyticketEvent ' + _?.toString());
      return new ErrorDetailmyticketState(_?.toString());
    }
  }
}

class LogoutDetailmyticketEvent extends DetailmyticketEvent {
  @override
  Future<DetailmyticketState> applyAsync(
      {DetailmyticketState currentState, DetailmyticketBloc bloc}) async{
    return new UnDetailmyticketState();
  }

  @override
  String toString() {
    return 'LogoutDetailmyticketEvent';
  }
}
