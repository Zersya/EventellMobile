import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:eventell/widgets/CustomItemListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/myevent/index.dart';

class MyeventScreen extends StatefulWidget {
  const MyeventScreen({
    Key key,
    @required MyeventBloc myeventBloc,
  })  : _myeventBloc = myeventBloc,
        super(key: key);

  final MyeventBloc _myeventBloc;

  @override
  MyeventScreenState createState() {
    return new MyeventScreenState(_myeventBloc);
  }
}

class MyeventScreenState extends State<MyeventScreen> {
  final MyeventBloc _myeventBloc;
  MyeventScreenState(this._myeventBloc);

  @override
  void initState() {
    super.initState();
    this._myeventBloc.dispatch(LoadMyeventEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyeventEvent, MyeventState>(
        bloc: widget._myeventBloc,
        builder: (
          BuildContext context,
          MyeventState currentState,
        ) {
          if (currentState is UnMyeventState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorMyeventState) {
            return new Container(
                child: new Center(
              child: new Text(currentState.errorMessage ?? 'Error'),
            ));
          }
          if (currentState is InMyeventState) {
            return new Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: currentState.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return Text(snapshot.error);

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          if (!snapshot.hasData)
                            return Center(child: Text(StringWord.emptyData));
                            
                          return ListView(
                            children: snapshot.data.documents
                                .map((DocumentSnapshot _doc) {
                              return CustomItemListEvent(
                                doc: _doc,
                              );
                            }).toList(),
                          );
                      }
                    }));
          }
        });
  }
}
