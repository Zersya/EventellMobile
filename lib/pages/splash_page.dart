import 'package:eventell/pages/auth_page.dart';
import 'package:eventell/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:eventell/Utils/utility.dart';
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
        if (currentState is SuccessLoginState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => MainPage()),
              (Route<dynamic> route) => false);
        }
        if (currentState is InLoginState) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BlocProvider(
                bloc: _loginBloc, child: AuthPage(),
              )),
              (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        body: Container(
          color: Coloring.colorMain,
          child: Center(
            child: Text(
              StringWord.title.toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          ),
        ),
      ),
    );
  }
}
