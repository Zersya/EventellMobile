import 'package:flutter/material.dart';
import 'package:eventell/shared/utility.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/register/index.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key key,
  }) : super(key: key);

  @override
  RegisterScreenState createState() {
    return new RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenState();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc();
    this._registerBloc.dispatch(LoadRegisterEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _registerBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizing.paddingContent),
      child: Column(
        children: <Widget>[
          Text(
            "CREATE YOUR ACCOUNT",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 25),
          FormRegister(
            registerBloc: _registerBloc,
          ),
        ],
      ),
    );
  }
}

class FormRegister extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final RegisterBloc registerBloc;

  FormRegister({Key key, this.scaffoldKey, this.registerBloc})
      : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  var _formKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();
  var _passwordConfController = TextEditingController();

  FocusNode _passwordFocus = FocusNode();
  FocusNode _passwordConfFocus = FocusNode();

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
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _emailController,
            decoration: InputDecoration(
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
            textInputAction: TextInputAction.next,
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
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_passwordConfFocus);
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            focusNode: _passwordConfFocus,
            controller: _passwordConfController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Sizing.borderRadiusFormText))),
              contentPadding: EdgeInsets.all(15.0),
              labelText: 'Confirm Password',
            ),
            validator: (val) {
              if (val.isEmpty) return 'Fill the confirmation password field';
              if (val != _passwordController.text)
                return 'Password is not same';
            },
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
      bloc: widget.registerBloc,
      listener: (BuildContext context, RegisterState currentState) {
        if (currentState is SuccessRegisterState) {
          _emailController.text = '';
          _passwordController.text = '';
          _passwordConfController.text = '';
          Scaffold.of(context).showSnackBar(SnackBar(
            content: new Text(currentState.successMessage ?? 'Success'),
          ));
        }
        if (currentState is ErrorRegisterState) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: new Text(currentState.errorMessage ?? 'Error'),
          ));
        }
      },
      child: BlocBuilder<RegisterEvent, RegisterState>(
          bloc: widget.registerBloc,
          builder: (
            BuildContext context,
            RegisterState currentState,
          ) {
            if (currentState is UnRegisterState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (currentState is LoadingRegisterState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              width: 150,
              height: 40,
              child: FlatButton(
                  color: Coloring.colorMain,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: _onLogin,
                  child: Text(
                    'REGISTER',
                    style:
                        TextStyle(color: Coloring.colorLoginText, fontSize: 18),
                  )),
            );
          }),
    );
  }

  void _onLogin() {
    if (_formKey.currentState.validate()) {
      widget.registerBloc.dispatch(
          SubmitRegisterEvent(_emailController.text, _passwordController.text));
    }
  }
}
