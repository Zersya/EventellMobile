import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/blocs/login/index.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:eventell/pages/main_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  LoginScreenState createState() {
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.dispatch(LoadLoginEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizing.paddingContent),
      child: Column(
        children: <Widget>[
          Text(
            'LOGIN',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          FormLogin(
            loginBloc: _loginBloc,
          ),
        ],
      ),
    );
  }
}

class FormLogin extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final LoginBloc loginBloc;

  FormLogin({Key key, this.scaffoldKey, this.loginBloc}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  var _formKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(Sizing.borderRadiusFormText),
            shadowColor: Colors.black54,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              controller: _emailController,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(Sizing.borderRadiusFormText),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Email',
              ),
              validator: ((val) {
                if (val.isEmpty) return 'Fill the email field';
              }),
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(Sizing.borderRadiusFormText),
            shadowColor: Colors.black54,
            child: TextFormField(
              focusNode: _passwordFocus,
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Sizing.borderRadiusFormText))),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Password',
              ),
              validator: (val) {
                if (val.isEmpty) return 'Fill the password field';
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          btnSubmit()
        ],
      ),
    ));
  }

  Widget btnSubmit() {
    return BlocListener(
      bloc: widget.loginBloc,
      listener: (BuildContext context, LoginState currentState) {
        if (currentState is LoggedInState) {
          Navigator.pushReplacementNamed(context, '/mainPage');
        }
        if (currentState is ErrorLoginState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(currentState.errorMessage),
          ));
        }
      },
      child: BlocBuilder<LoginEvent, LoginState>(
          bloc: widget.loginBloc,
          builder: (
            BuildContext context,
            LoginState currentState,
          ) {
            print('haha ' + currentState.toString());
            print('haha ' + widget.loginBloc.currentState.toString());

            if (currentState is UnLoginState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is LoadingLoginState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Material(
              elevation: 10,
              shadowColor: Colors.black87,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: FlatButton.icon(
                    color: Coloring.colorLogin,
                    icon: Icon(
                      MdiIcons.login,
                      color: Coloring.colorLoginText,
                    ),
                    onPressed: _onLogin,
                    label: Text(
                      'LOGIN',
                      style: TextStyle(color: Coloring.colorLoginText),
                    )),
              ),
            );
          }),
    );
  }

  void _onLogin() {
    if (_formKey.currentState.validate()) {
      widget.loginBloc.dispatch(
          SubmitLoginEvent(_emailController.text, _passwordController.text));
    }
  }
}
