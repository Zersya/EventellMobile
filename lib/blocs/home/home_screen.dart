import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/Utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/home/index.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:eventell/pages/auth_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  HomeScreenState createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    this._homeBloc.dispatch(LoadHomeEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _homeBloc,
      listener: (BuildContext context, HomeState currentState) {
        if (currentState is InHomeState) {
          if (currentState.user == null) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AuthPage()),
                (Route<dynamic> route) => false);
          }
        }
      },
      child: BlocBuilder<HomeEvent, HomeState>(
          bloc: _homeBloc,
          builder: (
            BuildContext context,
            HomeState currentState,
          ) {
            if (currentState is UnHomeState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is ErrorHomeState) {
              return new Container(
                  child: new Center(
                child: new Text(currentState.errorMessage ?? 'Error'),
              ));
            }
            if (currentState is InHomeState) {
              return Stack(children: <Widget>[
                Positioned(
                    top: 0, child: Image.asset('assets/graphics/ellipse.png')),
                Column(
                  children: <Widget>[
                    Expanded(
                      child: buildHome(
                          currentState.user, currentState.streamListEvent),
                    ),
                  ],
                ),
              ]);
            }

            return Container();
          }),
    );
  }

  buildHome(_user, _streamListEvent) {
    var _userEmail = _user.email.toString().split('@')[0][0].toUpperCase() +
        _user.email.toString().split('@')[0].substring(1);

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
        buildRecomendEvent(),
        SizedBox(
          height: 10,
        ),
        buildListEvent(_user, _streamListEvent),
      ],
    );
  }

  buildRecomendEvent() {
    return SizedBox(
      height: 150,
      child: PageView.builder(
        itemCount: 5,
        pageSnapping: true,
        controller: PageController(viewportFraction: 0.7, initialPage: 5),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizing.borderRadiusCard)),
            color: Colors.white,
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(Sizing.paddingPageView),
              child: Container(child: Center(child: Text('<3 you'))),
            ),
          );
        },
      ),
    );
  }

  buildListEvent(_user, _streamListEvent) {
    return StreamBuilder<QuerySnapshot>(
        stream: _streamListEvent,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.only(
                left: Sizing.paddingContent, right: Sizing.paddingContent),
            child: ListView.separated(
              itemCount: snapshot.data.documents.length,
              shrinkWrap: true,
              reverse: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data.documents[index].data;
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).pushNamed(Router.detailevent, arguments: {'dataEvent':data, 'dataUser': _user});
                  },
                  child: Card(
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
                                new CircularProgressIndicator(),
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
                                  Text(FlutterMoneyFormatter(
                                      amount: data['eventPrice'].toDouble(),
                                      settings: MoneyFormatterSettings(
                                        symbol: 'Rp. ',
                                        thousandSeparator: '.',
                                        decimalSeparator: ',',
                                        symbolAndNumberSeparator: ' ',
                                        fractionDigits: 2,
                                      )
                                  ).output.symbolOnLeft,
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
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
              separatorBuilder: (BuildContext context, int index) {
                if ((index % 3) == 0 && index != 0)
                  return SizedBox(
                    height: 50,
                    child: Card(
                      color: Colors.redAccent,
                      elevation: 8,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[Text('Iklan ' + index.toString())],
                        ),
                      ),
                    ),
                  );
                else
                  return SizedBox();
              },
            ),
          );
        });
  }
}

class CircleButtonCategory extends StatelessWidget {
  final name;
  final icon;
  const CircleButtonCategory({Key key, this.name, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizing.circleCategorySizePadd),
      child: Column(
        children: <Widget>[
          Container(
            width: Sizing.circleCategorySize,
            height: Sizing.circleCategorySize,
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: new Icon(
              this.icon,
              color: Colors.black,
            ),
          ),
          Text(this.name)
        ],
      ),
    );
  }
}
