import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../utility.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizing.paddingContent),
      child: Column(
        children: <Widget>[
          Text(
            'REGISTER',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          FormRegister(),
        ],
      ),
    );
  }
}

class FormRegister extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  FormRegister({Key key, this.scaffoldKey}) : super(key: key);

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
              textInputAction: TextInputAction.next,
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
              onFieldSubmitted: (value){
                FocusScope.of(context).requestFocus(_passwordConfFocus);
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
              focusNode: _passwordConfFocus,
              controller: _passwordConfController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(Sizing.borderRadiusFormText))),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Confirm Password',
              ),
              validator: (val) {
                if (val.isEmpty)
                  return 'Fill the confirmation password field';
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
            color: Coloring.colorRegister,
            icon: Icon(
              MdiIcons.login,
              color: Coloring.colorLoginText,
            ),
            onPressed: _onLogin,
            label: Text(
              'REGISTER',
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
