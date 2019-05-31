
import 'package:eventell/blocs/eventform/eventform_page.dart';
import 'package:eventell/blocs/myevent/myevent_page.dart';
import 'package:eventell/pages/auth_page.dart';
import 'package:eventell/pages/main_page.dart';
import 'package:eventell/pages/onboarding_page.dart';
import 'package:eventell/pages/splash_page.dart';
import 'package:flutter/material.dart';

class Router {
  static const String splashPage = '/splashPage';
  static const String onboardingPage = '/onboardingPage';
  static const String authPage = '/authPage';
  static const String mainPage = '/mainPage';
  static const String eventform = '/eventform';
  static const String myevent = '/myevent';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
            settings: RouteSettings(name: splashPage),
            builder: (_) => SplashPage());
      case onboardingPage:
        return MaterialPageRoute(
            settings: RouteSettings(name: onboardingPage),
            builder: (_) => OnBoardingPage());
      case authPage:
        return MaterialPageRoute(
            settings: RouteSettings(name: authPage),
            builder: (_) => AuthPage());
      case mainPage:
        return MaterialPageRoute(
            settings: RouteSettings(name: mainPage),
            builder: (_) => MainPage());
      case eventform:
        var data = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: eventform),
            builder: (_) => EventformPage(dataEdit: data,));
      case myevent:
        return MaterialPageRoute(
            settings: RouteSettings(name: myevent),
            builder: (_) => MyeventPage());
    }
  }
}