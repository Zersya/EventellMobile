import 'package:eventell/Utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/profile/index.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/pages/auth_page.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key key,
    @required ProfileBloc profileBloc,
  })  : _profileBloc = profileBloc,
        super(key: key);

  final ProfileBloc _profileBloc;

  @override
  ProfileScreenState createState() {
    return new ProfileScreenState(_profileBloc);
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc _profileBloc;
  ProfileScreenState(this._profileBloc);

  @override
  void initState() {
    super.initState();
    this._profileBloc.dispatch(LoadProfileEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _profileBloc,
      listener: (BuildContext context, ProfileState currentState) {
        if (currentState is LogoutedProfileState) {
          currentState.logout.then((_){
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => AuthPage()),
              (Route<dynamic> route) => false);
          });
        }
      },
      child: BlocBuilder<ProfileEvent, ProfileState>(
          bloc: widget._profileBloc,
          builder: (
            BuildContext context,
            ProfileState currentState,
          ) {
            if (currentState is LoadingProfileState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is UnProfileState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is ErrorProfileState) {
              return new Container(
                  child: new Center(
                child: new Text(currentState.errorMessage ?? 'Error'),
              ));
            }
            return new Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      color: Coloring.colorMain,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            StringWord.title,
                            style: TextStyle(fontSize: Sizing.fontTitleSize),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                color: Colors.white,
                                label: Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.black87),
                                ),
                                icon: Icon(
                                  MdiIcons.logout,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Logout"),
                                          content: Text("Anda yakin ?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Close"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("Logout"),
                                              onPressed: () {
                                                _profileBloc.dispatch(
                                                    LogoutProfileEvent());
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      elevation: 12,
                      margin: EdgeInsets.all(Sizing.paddingContent),
                      child: Padding(
                        padding: const EdgeInsets.all(Sizing.paddingContent),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(StringWord.profileAddEvent,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizing.fontProfileEventWordSize)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(StringWord.profileSubAddEvent,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize:
                                        Sizing.fontProfileEventSubWordSize)),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                color: Coloring.colorMain,
                                child: Text('New Event'),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EventformPage()));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          }),
    );
  }
}
