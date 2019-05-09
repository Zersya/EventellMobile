import 'package:eventell/pages/onboarding_page.dart';
import 'package:eventell/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:eventell/pages/main_page.dart';
import 'package:eventell/pages/auth_page.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/Utils/utility.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventell',
      theme: ThemeData(
        fontFamily: 'sf-compact'
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/splashPage': (BuildContext context) => new SplashPage(),
        '/onboardingPage': (BuildContext context) => new OnBoardingPage(),
        '/authPage': (BuildContext context) => new AuthPage(),
        '/mainPage': (BuildContext context) => new MainPage(),
        '/eventform': (BuildContext context) => new EventformPage()
      },
    );
  }
}
