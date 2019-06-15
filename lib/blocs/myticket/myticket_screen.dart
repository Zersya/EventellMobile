import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/ListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class MyTicketScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Ticket"),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            tabs: [
              Tab(
                child: Text("PURCHASED"),
              ),
              Tab(
                child: Text("WAITING"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Tab1(),
            Tab2(),
          ],
        ),
      ),
    );
  }
}

class Tab1 extends StatefulWidget{
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  MyTicketBloc _myTicketBloc = MyTicketBloc();

  @override
  void initState() {
    _myTicketBloc.dispatch(LoadMyTicketEvent(true));
    super.initState();
  }

  @override
  void dispose() {
    _myTicketBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTicketEvent, MyTicketState>(
      bloc: _myTicketBloc,
      builder: (context, currentState) {
        if (currentState is InMyTicketState) {
          return MultiProvider(
            providers: [
              StreamProvider<QuerySnapshot>.value(
                  value: currentState.streamTransactionEvent),
              StreamProvider<DocumentSnapshot>.value(
                  value: currentState.streamUser),
            ],
            child: ListEvent(
              isDetailTicket: true,
              isDetailEvent: false,
              isShowPaidButton: false,
            ),
          );
        }
        return Center(
            child: SpinKitCubeGrid(
          color: Coloring.colorMain,
        ));
      },
    );
  }
}

class Tab2 extends StatefulWidget {

  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  MyTicketBloc _myTicketBloc = MyTicketBloc();

  @override
  void initState() {
    _myTicketBloc.dispatch(LoadMyTicketEvent(false));
    super.initState();
  }

  @override
  void dispose() {
    _myTicketBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTicketEvent, MyTicketState>(
      bloc: _myTicketBloc,
      builder: (context, currentState) {
        if (currentState is UnMyTicketState) {
          return Center(
            child: SpinKitCubeGrid(color: Coloring.colorMain,),
          );
        }
        if (currentState is ErrorMyTicketState) {
          return new Container(
              child: new Center(
                child: new Text(currentState.errorMessage ?? 'Error'),
              ));
        }
        if (currentState is InMyTicketState) {
          return MultiProvider(
            providers: [
              StreamProvider<QuerySnapshot>.value(
                  value: currentState.streamTransactionEvent),
              StreamProvider<DocumentSnapshot>.value(
                  value: currentState.streamUser),
            ],
            child: ListEvent(
              isDetailTicket: true,
              isDetailEvent: false,
              isShowPaidButton: true,
            ),
          );
        }
        return Center(
            child: SpinKitCubeGrid(
          color: Coloring.colorMain,
        ));
      },
    );
  }
}
