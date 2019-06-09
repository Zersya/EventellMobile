import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/ListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class LikesScreen extends StatefulWidget {
  
  @override
  _LikesScreenState createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  
  LikesBloc _likesBloc = LikesBloc();
  
  @override
  void initState() {
    _likesBloc.dispatch(LoadLikesEvent());
    super.initState();
  }
  
  @override
  void dispose() {
    _likesBloc.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikesEvent, LikesState>(
      bloc: _likesBloc,
      builder: (context, currentState) {
        if(currentState is InLikesState){
          return MultiProvider(
            providers: [
              StreamProvider<QuerySnapshot>.value(value: currentState.streamListEvent),
              StreamProvider<DocumentSnapshot>.value(value: currentState.streamCurrentUser)
            ],
            child: ListEvent(),
          );
        }

        return Center(child: SpinKitCubeGrid(color: Coloring.colorMain,));

      }
    );
  }
}
