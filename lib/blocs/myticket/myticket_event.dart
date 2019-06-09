import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/models/ticket.dart';
import 'package:eventell/shared/models/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class MyTicketEvent {
  Future<MyTicketState> applyAsync({MyTicketState currentState, MyTicketBloc bloc});
}

class LoadMyTicketEvent extends MyTicketEvent {
  
  @override
  String toString() => 'LoadMyTicketEvent';

  @override
  Future<MyTicketState> applyAsync({MyTicketState currentState, MyTicketBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      
      Stream<QuerySnapshot> _streamTransactionEvent = Firestore.instance.collection("events")
          .where("orderedEvent", arrayContains: _user.email).snapshots();

      Stream<DocumentSnapshot> _streamUser = Firestore.instance
          .collection('users')
          .document(_user.email)
          .snapshots();

      return new InMyTicketState(_streamTransactionEvent, _streamUser);
    } catch (_) {
      print('LoadMyTicketEvent ' + _?.toString());
      return new ErrorMyTicketState(_?.toString());
    }
  }
}
