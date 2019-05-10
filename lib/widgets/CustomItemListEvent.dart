import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:flutter/material.dart';


class CustomItemListEvent extends StatelessWidget {
  final DocumentSnapshot doc;
  const CustomItemListEvent({
    Key key, this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizing.paddingContent,
          vertical: 5),
      child: Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Image.network(
                  doc['eventImage'],
                  filterQuality: FilterQuality.low,
                  height: 100,
                  fit: BoxFit.cover,
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(
                    Sizing.paddingContent),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(doc['eventName'],
                        style: TextStyle(
                            fontWeight:
                                FontWeight.bold)),
                    SizedBox(height: 15),
                    Text('Available Ticket : ' +
                        doc['eventAvaTicket']
                            .toString()),
                    Text('Price : ' +
                        doc['eventPrice'].toString()),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
