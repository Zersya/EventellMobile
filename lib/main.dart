import 'package:eventell/shared/router.dart';
import 'package:eventell/pages/splash_page.dart';
import 'package:flutter/material.dart';

import 'shared/utility.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      title: 'Eventell',
      theme: ThemeData(
        primaryColor: Coloring.colorMain,
        fontFamily: 'sf-compact'
      ),
      home: SplashPage(),
    );
  }
}
