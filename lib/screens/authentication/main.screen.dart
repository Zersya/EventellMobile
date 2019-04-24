import 'package:flutter/material.dart';
import 'package:eventell/blocs/register/index.dart';
import 'package:eventell/blocs/login/index.dart';
import 'package:eventell/screens/utility.dart';

class MainAuth extends StatefulWidget {
  @override
  _MainAuthState createState() => _MainAuthState();
}

class _MainAuthState extends State<MainAuth>
    with SingleTickerProviderStateMixin {
  var currentForm = 0;
  AnimationController _animationController;

  RegisterBloc _registerBloc;
  LoginBloc _loginBloc;

  List<Widget> formWidget;

  List<Color> colorBackground = [
    Coloring.colorRegister,
    Coloring.colorLogin,
  ];

  Animatable<Color> background = TweenSequence<Color>([
    TweenSequenceItem(
      weight: 1.0,
      tween: ColorTween(
        begin: Coloring.colorLogin,
        end: Coloring.colorRegister,
      ),
    ),
  ]);

  Animation translateFormLogin;
  Animation translateFormRegister;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: Sizing.durationAnimationColor),
        vsync: this);
    translateFormLogin =
        Tween<Offset>(begin: Offset(-1050, 0), end: Offset(0, 0)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.fastOutSlowIn));

    translateFormRegister =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(1050, 0)).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.fastOutSlowIn));
    _animationController.addListener(() {
      print(_animationController.status);
    });
    _animationController.forward();

    _registerBloc = RegisterBloc();
    _loginBloc = LoginBloc();
    formWidget = [
      LoginScreen(
        loginBloc: _loginBloc,
      ),
      RegisterScreen(
        registerBloc: _registerBloc,
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Scaffold(
              backgroundColor: background
                  .evaluate(AlwaysStoppedAnimation(_animationController.value)),
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      headerBuild(),
                      SizedBox(
                        child: Stack(children: <Widget>[
                          Transform.translate(
                              offset: translateFormLogin.value,
                              child: LoginScreen(
                                loginBloc: _loginBloc,
                              )),
                          Transform.translate(
                              offset: translateFormRegister.value,
                              child: RegisterScreen(
                                registerBloc: _registerBloc,
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  Row headerBuild() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: SizedBox(
              width: 100,
              height: 80,
              child: Container(
                  decoration: BoxDecoration(
                      color: Coloring.colorLogin,
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(Sizing.borderRadiusHeadBtn))),
                  child: Center(child: textHeadBuild('LOGIN')))),
          onTap: () {
            setState(() {
              _animationController.forward();
            });
          },
        ),
        GestureDetector(
          child: SizedBox(
              width: 100,
              height: 80,
              child: Container(
                  decoration: BoxDecoration(
                      color: Coloring.colorRegister,
                      borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(Sizing.borderRadiusHeadBtn))),
                  child: Center(child: textHeadBuild('REGISTER')))),
          onTap: () {
            setState(() {
              _animationController.reverse();
              // currentForm = 1;
            });
          },
        ),
      ],
    );
  }

  Text textHeadBuild(string) {
    return Text(string,
        style: TextStyle(
            color: Coloring.colorLoginText, fontWeight: FontWeight.bold));
  }
}
