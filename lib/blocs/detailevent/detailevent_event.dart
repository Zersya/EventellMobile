import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/blocs/detailevent/detailevent_state.dart';
import 'package:eventell/shared/models/user.dart';
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

  final User _user;
  final String eventId;
  final int eventLove;
  final List eventLoved;

  LoveDetaileventEvent(this.eventId, this.eventLove, this.eventLoved, this._user);

  @override
  String toString() => 'LoveDetaileventEvent';

  @override
  Future<DetaileventState> applyAsync({DetaileventState currentState, DetaileventBloc bloc}) async {
    try {
      bool isLoved = true;
      List newEventLoved = List();

      if (eventLove == 0) {
        newEventLoved.insert(0, _user.email);
      } else {
        eventLoved.forEach((v) {
          newEventLoved.add(v);
          if (v == _user.email)
            isLoved = false;
        });
        if (isLoved)
          newEventLoved.add(_user.email);
        else
          newEventLoved.remove(_user.email);
      }
      await Firestore.instance.collection("events").document(eventId)
          .updateData({
        'eventLove': isLoved ? (eventLove + 1) : (eventLove - 1),
        'eventLoved': newEventLoved
      });

      User newuser = _user;
      List newLovedEvent = List();

      bool userLovedEvent = false;
      if(newuser.lovedEvent != null){
        newuser.lovedEvent.forEach((v) {
          newLovedEvent.add(v);
          if (v == eventId)
            userLovedEvent = true;
        });
      }

      if (userLovedEvent)
        newLovedEvent.remove(eventId);
      else
        newLovedEvent.add(eventId);

      newuser.lovedEvent = newLovedEvent;
      await Firestore.instance.collection('users').document(_user.email)
          .updateData(newuser.toMap());

      return new LovedDetaileventState(
          isLoved ? (eventLove + 1) : (eventLove - 1), newEventLoved, isLoved, newuser);
    } catch (_) {
      print('LoveDetaileventEvent ' + _?.toString());
      return new ErrorDetaileventState(_?.toString());
    }
  }
}