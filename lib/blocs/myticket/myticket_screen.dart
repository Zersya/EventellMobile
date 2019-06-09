import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/ListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class MyTicketScreen extends StatefulWidget {
  @override
  _MyTicketScreenState createState() => _MyTicketScreenState();
}

class _MyTicketScreenState extends State<MyTicketScreen> {

  MyTicketBloc _myTicketBloc = MyTicketBloc();

  @override
  void initState() {
    _myTicketBloc.dispatch(LoadMyTicketEvent());
    super.initState();
  }

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
              Tab(child: Text("PURCHASED"),),
              Tab(child: Text("WAITING"),),
            ],
          ),
        ),
        body:TabBarView(
          children: [
            Center(child: Icon(Icons.hourglass_empty)),
            Tab_2(myTicketBloc: _myTicketBloc,)
          ],
        ),
      ),
    );
  }
}

class Tab_2 extends StatelessWidget {
  final myTicketBloc;

  const Tab_2({Key key, this.myTicketBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTicketEvent, MyTicketState>(
      bloc: myTicketBloc,
      builder: (context, currentState){
        if(currentState is InMyTicketState) {
          return MultiProvider(
            providers: [
              StreamProvider<QuerySnapshot>
                  .value(value: currentState.streamTransactionEvent),
              StreamProvider<DocumentSnapshot>
                  .value(value: currentState.streamUser),
            ],
            child: ListEvent(isWaitingTicket: true,),
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
