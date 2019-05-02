import 'package:eventell/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:eventell/blocs/register/index.dart';
import 'package:eventell/blocs/login/index.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/Utils/utility.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  var currentForm = 0;
  AnimationController _animationController;

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

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Stack(children: <Widget>[
                          Transform.translate(
                              offset: translateFormLogin.value,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  LoginScreen(),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: buildRichText(
                                        0,
                                        StringWord.registerMessage1,
                                        StringWord.registerMessage2),
                                  )
                                ],
                              )),
                          Transform.translate(
                              offset: translateFormRegister.value,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RegisterScreen(),
                                  buildRichText(1, StringWord.loginMessage1,
                                      StringWord.loginMessage2)
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  Widget buildRichText(int _mode, String _word1, String _word2) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _mode == 0
              ? _animationController.reverse()
              : _animationController.forward();
        });
      },
      child: SizedBox(
        height: 20,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: TextStyle(color: Colors.black),
              text: _word1,
              children: <TextSpan>[
                TextSpan(
                    style: TextStyle(
                        color: Coloring.colorMain, fontWeight: FontWeight.bold),
                    text: _word2),
              ]),
        ),
      ),
    );
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
