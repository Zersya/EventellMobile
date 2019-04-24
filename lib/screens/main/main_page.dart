import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'home.screen.dart';
import '../utility.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  List<Widget> listPage = [HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizing.heightAppBar),
            child: Padding(
              padding: const EdgeInsets.all(Sizing.paddingContent),
              child: Container(
                color: Coloring.colorAppbar,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: Sizing.paddingTopAppbar,
                    ),
                    Text('Hi !',
                        style: TextStyle(fontSize: Sizing.fontSizeAppBar)),
                    Text('Zein Ersyad',
                        style: TextStyle(
                            fontSize: Sizing.fontSizeAppBar,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            )),
        body: listPage[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'HOME',
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(
                  'FIND EVENT',
                  style: TextStyle(fontSize: 10),
                )),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.ticket),
                title: Text(
                  'MY TICKET',
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
          selectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          backgroundColor: Coloring.colorMain,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
