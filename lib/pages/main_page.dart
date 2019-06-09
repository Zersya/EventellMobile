import 'package:eventell/blocs/likes/likes_screen.dart';
import 'package:eventell/blocs/myticket/myticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/blocs/home/index.dart';
import 'package:eventell/blocs/profile/index.dart';
import 'package:eventell/shared/utility.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  List<Widget> listPage;

  @override
  void initState() {
    super.initState();
    listPage = [
      HomeScreen(),
      MyTicketScreen(),
      null,
      LikesScreen(),
      ProfileScreen()
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
