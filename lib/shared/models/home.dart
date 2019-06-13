import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  final Stream<QuerySnapshot> streamListEvent;
  final Stream<QuerySnapshot> streamRecommendedEvent;
  final Stream<DocumentSnapshot> streamCurrentUser;
  final Stream<DocumentSnapshot> streamCategory;

  HomeModel(this.streamListEvent, this.streamRecommendedEvent, this.streamCurrentUser, this.streamCategory);


}