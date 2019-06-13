import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/models/ticket.dart';
import 'package:eventell/shared/models/transaction.dart';
import 'package:eventell/shared/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class DetailMyTicketPage extends StatefulWidget {
  final detailTicket;

  const DetailMyTicketPage({Key key, this.detailTicket}) : super(key: key);
  @override
  _DetailMyTicketPageState createState() => _DetailMyTicketPageState();
}

class _DetailMyTicketPageState extends State<DetailMyTicketPage> {
  DetailmyticketBloc _detailMyTicketBloc = DetailmyticketBloc();

  TransactionTicket _transaction;

  @override
  void initState() {
    _transaction =
        TransactionTicket.fromMap(widget.detailTicket['dataEventTicket']);
    _detailMyTicketBloc
        .dispatch(LoadDetailmyticketEvent(_transaction.transactionId));
    super.initState();
  }

  @override
  void dispose() {
    _detailMyTicketBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Ticket"),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          Text("Event:",
              style: TextStyle(color: Coloring.colorMain, fontSize: 21)),
          Divider(height: 8.0),
          Container(
            child: Text(_transaction.event.eventName,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(height: 15.0),
          Text("Date & Time:",
              style: TextStyle(color: Coloring.colorMain, fontSize: 21)),
          Divider(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                MdiIcons.clockOutline,
                size: 21.0,
                color: Coloring.colorMain,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                    _transaction.event.eventDate +
                        "\n" +
                        _transaction.event.eventTime,
                    style: TextStyle(fontSize: 21.0)),
              ),
            ],
          ),
          Divider(height: 15.0),
          Text("Address:",
              style: TextStyle(color: Coloring.colorMain, fontSize: 21)),
          Divider(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.location_on,
                size: 21.0,
                color: Coloring.colorMain,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: Text(_transaction.event.eventAddress,
                      style: TextStyle(fontSize: 21.0)),
                ),
              )
            ],
          ),
          Divider(
            height: 30,
            color: Colors.black87,
          ),
          BlocBuilder(
            bloc: _detailMyTicketBloc,
            builder: (context, currentState) {
              if (currentState is InDetailmyticketState)
                return StreamProvider<QuerySnapshot>.value(
                  value: currentState.streamTicket,
                  child: ListTicket(),
                );

              return Center(
                  child: SpinKitCubeGrid(
                color: Coloring.colorMain,
              ));
            },
          )
        ],
      ),
    );
  }
}

class ListTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuerySnapshot _snapshotTicket = Provider.of<QuerySnapshot>(context);

    if (_snapshotTicket == null || _snapshotTicket.documents == null)
      return Center(
          child: SpinKitCubeGrid(
        color: Coloring.colorMain,
      ));
    else if (_snapshotTicket.documents.isEmpty)
      return Center(child: Text("No data!"));


    return ListView.builder(
      physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: _snapshotTicket.documents.length,
        itemBuilder: (context, index) {
          Ticket _ticket =
              Ticket.fromMap(_snapshotTicket.documents[index].data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Your Info - Ticket " + (index + 1).toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                  )),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("Nama :",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(_ticket.fullname,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("Email :",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(_ticket.email,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("NIM :",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(_ticket.nim,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text("No Telepon :",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(_ticket.noTelp,
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                ],
              ),
              Divider(
                height: 25,
                color: Colors.black87,
              )
            ],
          );
        });
  }
}
