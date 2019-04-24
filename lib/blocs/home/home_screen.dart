import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/home/index.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:eventell/Utils/utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
    @required HomeBloc homeBloc,
  })  : _homeBloc = homeBloc,
        super(key: key);

  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return new HomeScreenState(_homeBloc);
  }
}

class HomeScreenState extends State<HomeScreen> {
  final HomeBloc _homeBloc;
  HomeScreenState(this._homeBloc);

  @override
  void initState() {
    super.initState();
    this._homeBloc.dispatch(LoadHomeEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeEvent, HomeState>(
        bloc: widget._homeBloc,
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
            return Column(
              children: <Widget>[
                Expanded(
                  child: buildHome(currentState.user),
                ),
              ],
            );
          }
        });
  }

  ListView buildHome(_user) {
    var _userEmail = _user.email.toString().split('@')[0][0].toUpperCase() + _user.email.toString().split('@')[0].substring(1);
    
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
        Padding(
          padding: const EdgeInsets.only(
              left: Sizing.paddingContent, right: Sizing.paddingContent),
          child: Container(
            alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Coloring.colorMain,
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(Sizing.paddingInfoTitle),
              child: Text(StringWord.infoTitle,
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold))),
        ),
        SizedBox(
          height: 10,
        ),
        buildRecomendEvent(),
        SizedBox(
          height: 10,
        ),
        buildListEvent(),
      ],
    );
  }

  SizedBox buildRecomendEvent() {
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
            color: Coloring.colorMain,
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

  Padding buildListEvent() {
    return Padding(
      padding: const EdgeInsets.only(
          left: Sizing.paddingContent, right: Sizing.paddingContent),
      child: ListView.separated(
        itemCount: 12,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 150,
            child: Card(
              elevation: 8,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text('Hallo ' + index.toString())],
                ),
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
  }
}
