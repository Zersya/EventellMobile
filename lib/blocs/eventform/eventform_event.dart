import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

@immutable
abstract class EventformEvent {
  Future<EventformState> applyAsync(
      {EventformState currentState, EventformBloc bloc});
}

class LoadEventformEvent extends EventformEvent {
  final eventId;

  LoadEventformEvent(this.eventId);

  @override
  String toString() => 'LoadEventformEvent';

  @override
  Future<EventformState> applyAsync(
      {EventformState currentState, EventformBloc bloc}) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      FirebaseUser _user = await _auth.currentUser();
      DocumentSnapshot _doc = await Firestore.instance
          .collection('utility')
          .document('category')
          .get();

      List<String> _category = new List<String>();
      for (var item in _doc.data.values.first) {
        _category.add(item);
      }
      DocumentSnapshot _docEvents =
          await Firestore.instance.collection('events').document(eventId).get();
      return new InEventformState(_user, _category, _docEvents.data);
    } catch (_) {
      print('LoadEventformEvent ' + _?.toString());
      return new ErrorEventformState(_?.toString());
    }
  }
}

class SubmitEventformEvent extends EventformEvent {
  final bool isEdit;
  final String dataEdit,
      createdBy,
      eventName,
      eventDetail,
      eventCategory,
      eventTime,
      eventDate,
      eventAddress;
  final int eventAvaTicket, eventTak, eventPrice;
  final File image;

  SubmitEventformEvent(
      this.isEdit,
      this.dataEdit,
      this.createdBy,
      this.image,
      this.eventName,
      this.eventDetail,
      this.eventCategory,
      this.eventTime,
      this.eventDate,
      this.eventAddress,
      this.eventAvaTicket,
      this.eventTak,
      this.eventPrice);

  @override
  String toString() {
    return 'SubmitEventformEvent';
  }

  @override
  Future<EventformState> applyAsync(
      {EventformState currentState, EventformBloc bloc}) async {
    try {
      if (!isEdit) {
        final String url = await _uploadImage(this.image);

        String docId =
            Firestore.instance.collection('events').document().documentID;

        await Firestore.instance.collection('events').document(docId).setData({
          'eventId': docId,
          'createdBy': this.createdBy,
          'eventName': this.eventName,
          'eventDetail': this.eventDetail,
          'eventCategory': this.eventCategory,
          'eventTime': this.eventTime,
          'eventDate': this.eventDate,
          'eventAddress': this.eventAddress,
          'eventAvaTicket': this.eventAvaTicket,
          'eventTak': this.eventTak,
          'eventPrice': this.eventPrice,
          'eventImage': url
        });

        await Firestore.instance
            .collection('users')
            .document(this.createdBy)
            .collection('events')
            .document(docId)
            .setData({
          'isBuyed': false,
          'isCreated': true,
          'isLiked': false,
        });
      } else {
        if (this.image != null) {
          final String url = await _uploadImage(this.image);
          await Firestore.instance
              .collection('events')
              .document(this.dataEdit)
              .updateData({
            'eventId': this.dataEdit,
            'createdBy': this.createdBy,
            'eventName': this.eventName,
            'eventDetail': this.eventDetail,
            'eventCategory': this.eventCategory,
            'eventTime': this.eventTime,
            'eventDate': this.eventDate,
            'eventAddress': this.eventAddress,
            'eventAvaTicket': this.eventAvaTicket,
            'eventTak': this.eventTak,
            'eventPrice': this.eventPrice,
            'eventImage': url
          });
        } else {
          await Firestore.instance
              .collection('events')
              .document(this.dataEdit)
              .updateData({
            'eventId': this.dataEdit,
            'createdBy': this.createdBy,
            'eventName': this.eventName,
            'eventDetail': this.eventDetail,
            'eventCategory': this.eventCategory,
            'eventTime': this.eventTime,
            'eventDate': this.eventDate,
            'eventAddress': this.eventAddress,
            'eventAvaTicket': this.eventAvaTicket,
            'eventTak': this.eventTak,
            'eventPrice': this.eventPrice,
          });
        }
      }

      return AddedState();
    } catch (err) {
      return ErrorEventformState(err.message);
    }
  }

  Future<String> _uploadImage(image) async {
    final String filename = this.eventName +
        Random().nextInt(100).toString() +
        extension(image.path);
    final StorageReference storageRef =
        FirebaseStorage.instance.ref().child(filename);
    final StorageUploadTask uploadTask = storageRef.putFile(image);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    return url;
  }
}
