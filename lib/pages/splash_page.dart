import 'package:flutter/material.dart';
import 'package:eventell/shared/utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/login/index.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    _loginBloc.dispatch(LoadLoginEvent());
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState currentState) {
        if (currentState is LoggedInState) {
          Navigator.of(context).pushReplacementNamed('/mainPage');
        }
        if (currentState is InLoginState) {
          Navigator.of(context).pushReplacementNamed('/onboardingPage');
        }
      },
      child: Scaffold(
        body: Container(
          color: Coloring.colorMain,
          child: Center(
            child: Text(
              StringWord.title.toUpperCase(),
              style: TextStyle(color: Colors.black87, fontSize: 36, fontWeight: FontWeight.bold, fontFamily: 'sf-compact'),
            ),
          ),
        ),
      ),
    );
  }
}
