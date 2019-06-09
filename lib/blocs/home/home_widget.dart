import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/shared/models/home.dart';
import 'package:eventell/shared/models/user.dart';
import 'package:eventell/shared/router.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/CircleButtonCategory.dart';
import 'package:eventell/widgets/ListEvent.dart';
import 'package:eventell/widgets/MoneyFormater.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class HomeList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    FirebaseUser _user = Provider.of<FirebaseUser>(context);
    var _userEmail = _user.email.toString().split('@')[0][0].toUpperCase() +
        _user.email.toString().split('@')[0].substring(1);

    HomeModel _homeModel = Provider.of<HomeModel>(context);
    Stream<QuerySnapshot> _streamListEvent = _homeModel.streamListEvent;
    Stream<QuerySnapshot> _streamRecommendedEvent = _homeModel.streamRecommendedEvent;
    Stream<DocumentSnapshot> _streamCurrentUser = _homeModel.streamCurrentUser;

    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Sizing.paddingContent),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(StringWord.welcomeTitle,
                  style: TextStyle(fontSize: Sizing.fontSizeAppBar)),
              Text(_userEmail,
                  style: TextStyle(
                      fontSize: Sizing.fontSizeAppBar,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(Sizing.paddingContent),
          child: TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: StringWord.hintSearch,
                contentPadding: EdgeInsets.all(15.0),
                filled: true,
                fillColor: Colors.white70,
                suffixIcon: Icon(Icons.search)),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new CircleButtonCategory(
                  name: 'Category 1', icon: MdiIcons.music),
              new CircleButtonCategory(
                  name: 'Category 2', icon: MdiIcons.music),
              new CircleButtonCategory(
                  name: 'Category 3', icon: MdiIcons.music),
              new CircleButtonCategory(
                  name: 'Category 4', icon: MdiIcons.music),
              new CircleButtonCategory(
                  name: 'Category 5', icon: MdiIcons.music),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MultiProvider(
          providers: [
          StreamProvider<QuerySnapshot>
              .value(value: _streamRecommendedEvent,),
          StreamProvider<DocumentSnapshot>
              .value(value: _streamCurrentUser,),
          ],
          child: HomeRecommended(),
        ),
        SizedBox(
          height: 10,
        ),
        MultiProvider(
          providers: [
            StreamProvider<QuerySnapshot>
                .value(value: _streamListEvent,),
            StreamProvider<DocumentSnapshot>
                .value(value: _streamCurrentUser,),
          ],
          child: ListEvent(),
        )

      ],
    );
  }
}

class HomeRecommended extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    DocumentSnapshot snapshotUser = Provider.of<DocumentSnapshot>(context);
    QuerySnapshot snapshot = Provider.of<QuerySnapshot>(context);


    if(snapshot == null || snapshotUser == null ){
      return SpinKitCubeGrid(color: Coloring.colorMain,);
    }
    User _user = User.fromMap(snapshotUser.data);
    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: snapshot.documents.length,
        pageSnapping: true,
        controller: PageController(viewportFraction: 0.9, initialPage: 0),
        itemBuilder: (BuildContext context, int index) {
          var data = snapshot.documents[index].data;

          return GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(Router.detailevent, arguments: {'dataEvent':data, 'dataUser': _user});
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizing.borderRadiusCard)),
              color: Colors.white,
              elevation: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 150,
                      imageUrl: data['eventImage'],
                      placeholder: (context, url) =>
                          SpinKitDoubleBounce(color: Coloring.colorMain,),
                      errorWidget: (context, url, error) =>
                      new Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data['eventName'],
                                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            Divider(height: 5,),
                            MoneyFormater(money: data['eventPrice'], textStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),

                            Divider(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(MdiIcons.clockOutline, size: 13.0, color: Coloring.colorMain,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(data['eventDate'] + "\n" + data['eventTime'],
                                      style: TextStyle(fontSize: 13.0)),
                                ),
                              ],
                            ),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.location_on, size: 13.0, color: Coloring.colorMain,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.45,
                                    child: Text(data['eventAddress'],
                                        style: TextStyle(fontSize: 13.0)),
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



