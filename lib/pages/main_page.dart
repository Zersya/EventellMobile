import 'package:eventell/blocs/eventform/index.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/blocs/home/index.dart';
import 'package:eventell/blocs/profile/index.dart';
import 'package:eventell/Utils/utility.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  HomeBloc _homeBloc;
  ProfileBloc _profileBloc;

  List<Widget> listPage;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc();
    _profileBloc = ProfileBloc();
    listPage = [
      HomeScreen(
        homeBloc: _homeBloc,
      ),
      null,
      null,
      null,
      ProfileScreen(
        profileBloc: _profileBloc,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: listPage[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 25,
          selectedFontSize: Sizing.selectedFontSize,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'HOME',
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.ticket),
                title: Text(
                  'MY TICKET',
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                title: Text(
                  'ADD EVEBT',
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.heart),
                title: Text(
                  'LIKES',
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  'PROFILE',
                  style: TextStyle(fontSize: 10),
                )),
          ],
          selectedItemColor: Coloring.colorMain,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          backgroundColor: Coloring.bottomAppbar,
          onTap: (index) {
            if (index != 2) {
              setState(() {
                currentIndex = index;
              });
            } else {
              Navigator.of(context).pushNamed('/eventform');
            }
          },
        ));
  }
}
