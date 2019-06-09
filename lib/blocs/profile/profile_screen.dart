import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/CustomSubmitButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/profile/index.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:avataaar_image/avataaar_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key key,
  })  :
        super(key: key);

  @override
  ProfileScreenState createState() {
    return new ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    this._profileBloc.dispatch(LoadProfileEvent());
  }

  @override
  void dispose() {
    super.dispose();
//    _profileBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _profileBloc,
      listener: (BuildContext context, ProfileState currentState) {
        print(currentState);
        if (currentState is LogoutedProfileState) {
          Navigator.of(context).pushNamedAndRemoveUntil('/authPage', ModalRoute.withName('/'));
        }
      },
      child: BlocBuilder<ProfileEvent, ProfileState>(
          bloc: _profileBloc,
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

            return ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(Sizing.paddingEachContent),
                  alignment: Alignment.center,
                  color: Coloring.colorMain,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AvataaarImage(
                        avatar: currentState is InProfileState
                            ? currentState.avataaar
                            : Avataaar.random(),
                        errorImage: Icon(Icons.error),
                        placeholder: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        width: 128.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTextName(currentState),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizing.paddingContent),
                  child: ListView(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('My Event',
                                style: TextStyle(color: Colors.black87)),
                            onTap: () {
                              Navigator.of(context).pushNamed('/myevent');
                            },
                          ),
                          Divider(
                            color: Colors.black87,
                            height: 1,
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: Text('Purchase History',
                                style: TextStyle(color: Colors.black87)),
                            onTap: () {},
                          ),
                          Divider(
                            color: Colors.black87,
                            height: 1,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Sizing.paddingContent),
                  child: CustomSubmitButton(
                    event: () => _buildShowDialog(context),
                    icon: MdiIcons.logout,
                    label: 'Logout',
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget buildTextName(ProfileState currentState) {
    if (currentState is InProfileState) {
      var _userEmail =
          currentState.user.email.toString().split('@')[0][0].toUpperCase() +
              currentState.user.email.toString().split('@')[0].substring(1);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            _userEmail,
            style: TextStyle(
                fontSize: Sizing.fontSizeAppBar, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            currentState.user.email,
            style: TextStyle(fontSize: Sizing.fontSizeSubAppBar),
          ),
        ],
      );
    }
    return SizedBox();
  }

  Future _buildShowDialog(BuildContext context) {
    print(_profileBloc.state);
    return showDialog(
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
                  _profileBloc.dispatch(LogoutProfileEvent());
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
