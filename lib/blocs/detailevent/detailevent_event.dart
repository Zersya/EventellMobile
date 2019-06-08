import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/blocs/detailevent/detailevent_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'index.dart';

@immutable
abstract class DetaileventEvent {
  Future<DetaileventState> applyAsync({DetaileventState currentState, DetaileventBloc bloc});
}

class LoadDetaileventEvent extends DetaileventEvent {
  @override
  String toString() => 'LoadDetaileventEvent';

  @override
  Future<DetaileventState> applyAsync({DetaileventState currentState, DetaileventBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();

      return new InDetaileventState(_user.email);
    } catch (_) {
      print('LoadDetaileventEvent ' + _?.toString());
      return new ErrorDetaileventState(_?.toString());
    }
  }
}


class LoveDetaileventEvent extends DetaileventEvent {

  final String eventId;
  final int eventLove;
  final List eventLoved;

  LoveDetaileventEvent(this.eventId, this.eventLove, this.eventLoved);

  @override
  String toString() => 'LoveDetaileventEvent';

  @override
  Future<DetaileventState> applyAsync({DetaileventState currentState, DetaileventBloc bloc}) async {
    try {
      bool isLoved = true;
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      List newEventLoved = List();
      
      if(eventLove == 0) {
        newEventLoved.insert(0, _user.email);
      }else {
        eventLoved.forEach((v) {
          newEventLoved.add(v);
          if(v == _user.email)
            isLoved = false;
        });
        if(isLoved)
          newEventLoved.add(_user.email);
        else
          newEventLoved.remove(_user.email);

      }
      await Firestore.instance.collection("events").document(eventId)
          .updateData({'eventLove': isLoved ? (eventLove+1) : (eventLove-1), 'eventLoved':newEventLoved});
      return new LovedDetaileventState(isLoved ? (eventLove+1) : (eventLove-1), newEventLoved, isLoved);
    } catch (_) {
      print('LoveDetaileventEvent ' + _?.toString());
      return new ErrorDetaileventState(_?.toString());
    }
  }
}