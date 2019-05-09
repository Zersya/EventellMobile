import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/login/index.dart';
import 'package:eventell/Utils/utility.dart';

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
    return Container(
      padding: const EdgeInsets.all(Sizing.paddingContent),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            "LET'S GET STARTED",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 35,
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
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _emailController,
            decoration: InputDecoration(
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
          SizedBox(
            height: 20,
          ),
          TextFormField(
            focusNode: _passwordFocus,
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
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
          SizedBox(
            height: 25,
          ),
          btnSubmit(),
         
          
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
            return SizedBox(
              width: 150,
              height: 40,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  color: Coloring.colorMain,
                  onPressed: _onLogin,
                  child: Text(
                    'LOGIN',
                    style:
                        TextStyle(color: Coloring.colorLoginText, fontSize: 18),
                  )),
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
