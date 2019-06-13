
import 'package:eventell/blocs/detailevent/detailevent_page.dart';
import 'package:eventell/blocs/detailmyticket/detailmyticket_page.dart';
import 'package:eventell/blocs/eventform/eventform_page.dart';
import 'package:eventell/blocs/getticket/getticket_page.dart';
import 'package:eventell/blocs/myevent/myevent_page.dart';
import 'package:eventell/blocs/payment/payment_page.dart';
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
  static const String detailevent = '/detailevent';
  static const String getticket = '/getticket';
  static const String payment = '/payment';
  static const String detailticket = '/detailticket';


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
      case detailevent:
        var data = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: detailevent),
            builder: (_) => DetaileventPage(data: data,));
      case getticket:
        final data = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: getticket),
            builder: (_) => GetTicket(dataOrder: data,));
      case payment:
      final data = settings.arguments;
      return MaterialPageRoute(
          settings: RouteSettings(name: payment),
          builder: (_) => PaymentPage(data: data,));
      case detailticket:
        final data = settings.arguments;
        return MaterialPageRoute(
            settings: RouteSettings(name: detailticket),
            builder: (_) => DetailMyTicketPage(detailTicket: data,));
    }
  }
}