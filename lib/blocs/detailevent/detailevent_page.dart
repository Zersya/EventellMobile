import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventell/Utils/router.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

import 'index.dart';

class DetaileventPage extends StatefulWidget {
  final data;

  const DetaileventPage({Key key, this.data}) : super(key: key);

  @override
  _DetaileventPageState createState() => _DetaileventPageState();
}

class _DetaileventPageState extends State<DetaileventPage> {
  int _ticket = 0;

  DetaileventBloc _detaileventBloc = DetaileventBloc();
  Color _colorHeart = Colors.grey;
  bool isLoved = false;

  @override
  void initState() {
    List listLoved = widget.data['dataEvent']['eventLoved'];
    var user = widget.data['dataUser'];
    listLoved.forEach((v){
      if(v == user.email) isLoved = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data['dataEvent'];
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, innerBox) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 300.0,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                elevation: 5.0,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black87,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: PinchZoomImage(
                            image: CachedNetworkImage(
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: data['eventImage'],
                              placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                            ),
                          ),
                        );
                      });
                },
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: data['eventImage'],
                  placeholder: (context, url) =>
                      new CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          )
        ];
      },
      body: Container(
        child: Stack(children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data['eventName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              FlutterMoneyFormatter(
                                  amount: data['eventPrice'].toDouble(),
                                  settings: MoneyFormatterSettings(
                                    symbol: 'Rp. ',
                                    thousandSeparator: '.',
                                    decimalSeparator: ',',
                                    symbolAndNumberSeparator: ' ',
                                    fractionDigits: 2,
                                  )).output.symbolOnLeft,
                              style: TextStyle(fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                MdiIcons.circle,
                                color: Coloring.colorMain,
                                size: 18.0,
                              ),
                            ),
                            Text(
                              data['eventTak'].toString() + " TAK",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Chip(
                              label: Text(data['createdBy']),
                            ),
                            BlocListener<DetaileventEvent, DetaileventState>(
                              bloc: _detaileventBloc,
                              listener: (context, currentState){
                                if(currentState is LovedDetaileventState){
                                  setState(() {
                                    data['eventLove'] = currentState.eventLove;
                                    data['eventLoved'] = currentState.eventLoved;
                                    isLoved = currentState.isLoved;
                                  });
                                  _detaileventBloc.dispatch(LoadDetaileventEvent());
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  Text(data['eventLove'].toString()),
                                  IconButton(
                                    icon: Icon(
                                      MdiIcons.heart,
                                    ),
                                    color: isLoved ? Colors.red:Colors.grey,
                                    onPressed: () {
                                      _detaileventBloc.dispatch(
                                          LoveDetaileventEvent(
                                              data['eventId'],
                                              data['eventLove'],
                                              data['eventLoved']));
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 30,
                          color: Colors.black87,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              MdiIcons.clockOutline,
                              size: 24.0,
                              color: Coloring.colorMain,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  data['eventDate'] + "\n" + data['eventTime'],
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 24.0,
                              color: Coloring.colorMain,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(data['eventAddress'],
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 25,
                          color: Colors.black87,
                        ),
                        Text("About", style: TextStyle(fontSize: 24.0)),
                        Divider(
                          height: 15,
                        ),
                        Text(data['eventDetail']),
                        Divider(
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                color: Coloring.colorMain,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        MdiIcons.minus,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        setState(() {
                          _ticket -= 1;
                        });
                      },
                    ),
                    Text(_ticket.toString()),
                    IconButton(
                      icon: Icon(MdiIcons.plus, color: Colors.black87),
                      onPressed: () {
                        setState(() {
                          _ticket += 1;
                        });
                      },
                    ),
                    FlatButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushNamed(Router.getticket,
                            arguments: {
                              'countTicket': _ticket,
                              'dataEvent': data
                            });
                      },
                      child: Text(
                        "GET TICKET",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ))
        ]),
      ),
    ));
  }
}
