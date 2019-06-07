import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DetaileventPage extends StatefulWidget {
  final detailEvent;

  const DetaileventPage({Key key, this.detailEvent}) : super(key: key);

  @override
  _DetaileventPageState createState() => _DetaileventPageState();
}

class _DetaileventPageState extends State<DetaileventPage> {

  int _ticket = 0;

  @override
  Widget build(BuildContext context) {
    var data = widget.detailEvent;
    return Scaffold(
        body: Container(
      child: Stack(children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                    imageUrl: data['eventImage'],
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 50),
                      child: FloatingActionButton(
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
                  ),
                ],
              ),
            ),
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
                            "Rp. " + data['eventPrice'].toString(),
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
                          Row(
                            children: <Widget>[
                              Text("190"),
                              Icon(
                                MdiIcons.heart,
                                color: Colors.grey,
                              ),
                            ],
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
                            child: Text(data['eventAddress'],
                                style: TextStyle(fontSize: 18.0)),
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
                  IconButton(icon: Icon(MdiIcons.minus, color: Colors.black87,), onPressed: (){setState(() {
                    _ticket-=1;
                  });},),
                  Text(_ticket.toString()),
                  IconButton(icon: Icon(MdiIcons.plus, color: Colors.black87), onPressed: (){setState(() {
                    _ticket+=1;
                  });},),
                  FlatButton(color: Colors.white, onPressed: (){}, child: Text("GET TICKET", style: TextStyle(fontWeight: FontWeight.bold),),)
                ],
              ),
            ))
      ]),
    ));
  }
}
