import 'package:flutter/material.dart';
import '../utility.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
          FormLogin(),
        ],
      ),
    );
  }
}

class FormLogin extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  FormLogin({Key key, this.scaffoldKey}) : super(key: key);

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
              onFieldSubmitted: (value){
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
  }

  void _onLogin() {
    if (_formKey.currentState.validate()) {
      // _emailController.text = 'zeinersyad';
      // _passwordController.text = '123456';
    }
  }
}
