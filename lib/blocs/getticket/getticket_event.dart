import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/models/ticket.dart';
import 'package:eventell/shared/models/transaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class GetTicketEvent {
  Future<GetTicketState> applyAsync({GetTicketState currentState, GetTicketBloc bloc});
}

class SubmitTicketEvent extends GetTicketEvent {

  final event;
  final List fullNameController;
  final List emailController;
  final List nimController;
  final List noTelpController;

  SubmitTicketEvent({this.event, this.fullNameController, this.emailController, this.nimController, this.noTelpController});

  @override
  String toString() => 'SubmitTicketEvent';

  @override
  Future<GetTicketState> applyAsync({GetTicketState currentState, GetTicketBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();

      String docId = Firestore.instance.collection("users")
          .document(_user.email).collection("transactionTicket")
          .document().documentID;

      TransactionTicket _transactionTicket = TransactionTicket.fromMap({
        "eventId": event['eventId'],
        "validUntil": DateTime.now().add(Duration(days: 3)).millisecondsSinceEpoch,
        "paymentFile": null,
        "isPaid": false,
      });
      List _orderedEvent = List();

      if(event['orderedEvent'] != null) {
        event['orderedEvent'].forEach((v) {
          _orderedEvent.add(v);
        });
      }
      _orderedEvent.add(_user.email);

      for(int i = 0; i < fullNameController.length; i++){
        Ticket _ticket = Ticket.fromMap({
          "eventId": event['eventId'],
          "boughtBy": _user.email,
          "fullname": fullNameController[i].text,
          "email": emailController[i].text,
          "nim": nimController[i].text,
          "noTelp": noTelpController[i].text,
        });

        await Firestore.instance.collection("users")
            .document(_user.email).collection("transactionTicket")
            .document(docId).setData(_transactionTicket.toMap());
        await Firestore.instance.collection("users")
            .document(_user.email).collection("transactionTicket")
            .document(docId).collection("ticket").document()
            .setData(_ticket.toMap());

        await Firestore.instance.collection("events")
            .document(event['eventId'])
            .updateData({'orderedEvent': _orderedEvent});
      }

      return new SubmittedGetTicketState(_transactionTicket.validUntil);
    } catch (_) {
      print('SubmitTicketEvent ' + _?.toString());
      return new ErrorGetTicketState(_?.toString());
    }
  }
}
