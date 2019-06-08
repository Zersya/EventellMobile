import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'index.dart';

@immutable
abstract class GetTicketEvent {
  Future<GetTicketState> applyAsync({GetTicketState currentState, GetTicketBloc bloc});
}

class SubmitTicketEvent extends GetTicketEvent {

  final String eventId;
  final List fullNameController;
  final List emailController;
  final List nimController;
  final List noTelpController;

  SubmitTicketEvent({this.eventId, this.fullNameController, this.emailController, this.nimController, this.noTelpController});

  @override
  String toString() => 'SubmitTicketEvent';

  @override
  Future<GetTicketState> applyAsync({GetTicketState currentState, GetTicketBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();

      for(int i = 0; i < fullNameController.length; i++){
        await Firestore.instance.collection("users")
            .document(_user.email).collection("tickets")
            .document().setData({
          "eventId": eventId,
          "fullName": fullNameController[i].text,
          "email": emailController[i].text,
          "nim": nimController[i].text,
          "noTelp": noTelpController[i].text
        });
        await Firestore.instance.collection("events")
            .document(eventId).collection("tickets")
            .document().setData({
          "fullName": fullNameController[i].text,
          "email": emailController[i].text,
          "nim": nimController[i].text,
          "noTelp": noTelpController[i].text
        });
      }

      return new SubmittedGetTicketState();
    } catch (_) {
      print('SubmitTicketEvent ' + _?.toString());
      return new ErrorGetTicketState(_?.toString());
    }
  }
}
