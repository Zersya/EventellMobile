import 'package:eventell/shared/models/home.dart';
import 'package:eventell/blocs/home/home_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/home/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/pages/auth_page.dart';
import 'package:provider/provider.dart';

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
                child: SpinKitCubeGrid(color: Coloring.colorMain,),
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
                Align(
                    alignment: Alignment.topCenter, child: Image.asset('assets/graphics/ellipse.png')),
                Column(
                  children: <Widget>[
                    Expanded(
                      child: MultiProvider(
                        providers: [
                          Provider<FirebaseUser>.value(value: currentState.user),
                          Provider<HomeModel>.value(value: HomeModel(
                              currentState.streamListEvent,
                              currentState.streamRecomendedEvent,
                              currentState.streamCurrentUser
                          )),
                        ],
                        child: HomeList(),
                      ),
                    ),
                  ],
                ),
              ]);
            }

            return Container();
          }),
    );
  }
}

