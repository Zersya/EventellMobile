import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/CustomSmallButton.dart';
import 'package:flutter/material.dart';

class CustomItemListEvent extends StatelessWidget {
  final DocumentSnapshot doc;
  const CustomItemListEvent({
    Key key,
    this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            flex: 1,
            child: Card(
              elevation: 5.0,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: 100,
                imageUrl: doc['eventImage'],
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
              )
            )),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: Sizing.paddingContent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(doc['eventName'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    'Available Ticket : ' + doc['eventAvaTicket'].toString()),
                Text('Price : ' + doc['eventPrice'].toString()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomSmallButton(
                      color: Coloring.colorMain,
                      textColor: Colors.black87,
                      label: 'Edit Event',
                      onPressed: (){
                        Navigator.of(context).pushNamed('/eventform', arguments: doc['eventId']);
                      },
                    ),
                    CustomSmallButton(
                      color: Colors.black87,
                      textColor: Coloring.colorMain,
                      label: 'Go Premium',
                      onPressed: (){
                        Scaffold.of(context).showSnackBar(SnackBar(content:Text('Not available yet.')));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
