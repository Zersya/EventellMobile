import 'package:eventell/shared/router.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/CustomField.dart';
import 'package:eventell/widgets/MoneyFormater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'index.dart';

class GetTicket extends StatefulWidget {
  final dataOrder;
  const GetTicket({Key key, this.dataOrder}) : super(key: key);

  @override
  _GetTicketState createState() => _GetTicketState();
}

class _GetTicketState extends State<GetTicket> {
  List<Widget> _listForm = new List();

  List<TextEditingController> _fullNameController = new List();
  List<TextEditingController> _emailController = new List();
  List<TextEditingController> _nimController = new List();
  List<TextEditingController> _noTelpController = new List();

  List<GlobalKey<FormState>> _formKey = new List();

  GetTicketBloc _getTicketBloc = GetTicketBloc();

  @override
  void initState() {
    for (int i = 0; i < widget.dataOrder['countTicket']; i++) {
      _fullNameController.add(TextEditingController());
      _emailController.add(TextEditingController());
      _nimController.add(TextEditingController());
      _noTelpController.add(TextEditingController());

      _formKey.add(GlobalKey<FormState>());

      _listForm.add(Text(
        "Your Info - Ticket " + (i + 1).toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ));

      _listForm.add(FormTicket(
        fullNameController: _fullNameController[i],
        emailController: _emailController[i],
        nimController: _nimController[i],
        noTelpController: _noTelpController[i],
        formKey: _formKey[i],
      ));

      _listForm.add(Divider(
        height: 35,
        color: Colors.black87,
      ));
    }
    super.initState();
  }

  @override
  void dispose() {
    _getTicketBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _dataEvent = widget.dataOrder['dataEvent'];
    var _ticket = widget.dataOrder['countTicket'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Get Your Ticket"),
      ),
      body: BlocListener(
        bloc: _getTicketBloc,
        listener: (context, currentState) {
          if (currentState is SubmittedGetTicketState) {
            Navigator.of(context)
                .pushReplacementNamed(Router.payment, arguments: {
              'moneyValue': _dataEvent['eventPrice'] * _ticket,
              'validUntil': currentState.validUntil
            });
          }
        },
        child: BlocBuilder<GetTicketEvent, GetTicketState>(
            bloc: _getTicketBloc,
            builder: (context, currentstate) {
              if (currentstate is LoadingGetTicketState) {
                return Center(
                    child: SpinKitCubeGrid(
                  color: Coloring.colorMain,
                ));
              }

              return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(children: <Widget>[
                    ListView(
                      padding: EdgeInsets.all(10.0),
                      children: <Widget>[
                        Text(
                          _dataEvent['eventName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Divider(
                          height: 10,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            MoneyFormater(
                              money: _dataEvent['eventPrice'],
                              textStyle: TextStyle(fontSize: 18.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                MdiIcons.circle,
                                color: Coloring.colorMain,
                                size: 18.0,
                              ),
                            ),
                            Text(
                              _dataEvent['eventTak'].toString() + " TAK",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              MdiIcons.clockOutline,
                              size: 24.0,
                              color: Coloring.colorMain,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                  _dataEvent['eventDate'] +
                                      "\n" +
                                      _dataEvent['eventTime'],
                                  style: TextStyle(fontSize: 18.0)),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 24.0,
                              color: Coloring.colorMain,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(_dataEvent['eventAddress'],
                                    style: TextStyle(fontSize: 18.0)),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          height: 32,
                          color: Colors.black87,
                        ),
                        Text(
                          "TOTAL : " + _ticket.toString() + " Ticket",
                          style: TextStyle(fontSize: 21),
                        ),
                        Divider(
                          height: 5,
                        ),
                        MoneyFormater(
                          money: _dataEvent['eventPrice'].toDouble() * _ticket,
                          textStyle: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Coloring.colorMain),
                        ),
                        Divider(
                          height: 20,
                        ),
                        ..._listForm,
                        Divider(
                          height: 80,
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Coloring.colorMain,
                            child: _submitWidget(currentstate, _dataEvent)))
                  ]));
            }),
      ),
    );
  }

  Widget _submitWidget(currentstate, _dataEvent) {
    return FlatButton(
      color: Coloring.colorMain,
      onPressed: () {
        bool _isValid = true;
        for (var key in _formKey) {
          if (!key.currentState.validate()) {
            _isValid = false;
          }
        }

        if (_isValid) {
          _getTicketBloc.dispatch(SubmitTicketEvent(
              event: _dataEvent,
              emailController: _emailController,
              fullNameController: _fullNameController,
              nimController: _nimController,
              noTelpController: _noTelpController));
        }
      },
      child: Text(
        "PAY NOW",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ignore: must_be_immutable
class FormTicket extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController nimController;
  final TextEditingController noTelpController;

  final formKey;

  FormTicket(
      {Key key,
      this.fullNameController,
      this.emailController,
      this.nimController,
      this.noTelpController,
      this.formKey})
      : super(key: key);

  FocusNode _fullNameFocus = FocusNode();
  FocusNode _emailFocus = FocusNode();
  FocusNode _nimFocus = FocusNode();
  FocusNode _noTelpFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          CustomField(
            label: "Full Name",
            controller: fullNameController,
            focusOwn: _fullNameFocus,
            focusTo: _emailFocus,
            textInputAction: TextInputAction.next,
          ),
          CustomField(
            label: "Email",
            controller: emailController,
            focusOwn: _emailFocus,
            focusTo: _nimFocus,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
          ),
          CustomField(
            label: "NIM",
            controller: nimController,
            focusOwn: _nimFocus,
            focusTo: _noTelpFocus,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
          ),
          CustomField(
            label: "No Telp",
            controller: noTelpController,
            focusOwn: _noTelpFocus,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.number,
          )
        ],
      ),
    );
  }
}
