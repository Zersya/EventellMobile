import 'dart:io';
import 'package:eventell/blocs/eventform/eventform_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:eventell/widgets/CustomMultiField.dart';
import 'package:eventell/widgets/CustomField.dart';
import 'package:eventell/widgets/CustomDateTime.dart';
import 'package:eventell/widgets/CustomSubmitButton.dart';

class EventformScreen extends StatefulWidget {
  const EventformScreen({
    Key key,
    @required EventformBloc eventformBloc,
  })  : _eventformBloc = eventformBloc,
        super(key: key);

  final EventformBloc _eventformBloc;

  @override
  EventformScreenState createState() {
    return new EventformScreenState(_eventformBloc);
  }
}

class EventformScreenState extends State<EventformScreen> {
  final EventformBloc _eventformBloc;
  EventformScreenState(this._eventformBloc);

  @override
  void initState() {
    super.initState();
    this._eventformBloc.dispatch(LoadEventformEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: this._eventformBloc,
      listener: (BuildContext context, EventformState currentState) {
        if (currentState is AddedState) {
          this._eventformBloc.dispatch(LoadEventformEvent());
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/mainPage'));
                },
                child: Dialog(
                    backgroundColor: Coloring.colorMain,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 45,
                          ),
                          Text(
                            StringWord.eventSuccess,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Sizing.fontSuccessInfo,
                            ),
                          )
                        ],
                      ),
                    )),
              );
            },
          );
        }
      },
      child: BlocBuilder<EventformEvent, EventformState>(
          bloc: this._eventformBloc,
          builder: (
            BuildContext context,
            EventformState currentState,
          ) {
            if (currentState is UnEventformState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (currentState is ErrorEventformState) {
              return new Container(
                  child: new Center(
                child: new Text(currentState.errorMessage ?? 'Error'),
              ));
            }
            return ScreenForm(eventformBloc: widget._eventformBloc);
          }),
    );
  }
}

class ScreenForm extends StatefulWidget {
  const ScreenForm({
    Key key,
    this.eventformBloc,
  }) : super(key: key);

  final EventformBloc eventformBloc;
  @override
  _ScreenFormState createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  File _image;

  @override
  void initState() {
    super.initState();
  }

  Future getImage(source) async {
    var image = await ImagePicker.pickImage(
        source: source, maxHeight: 720, maxWidth: 1280);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Sizing.paddingContent),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 3,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Sizing.borderRadiusCard),
                    border: Border.all(width: 1.5, color: Colors.grey)),
                child: _image == null
                    ? Align(
                        child: Text(
                          'Add your poster',
                        ),
                        alignment: Alignment.center,
                      )
                    : Image.file(
                        _image,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
              ),
              onTap: () => _buildShowBottomSheet(context),
            ),
            SizedBox(
              height: 20,
            ),
            FormAddEvent(eventformBloc: widget.eventformBloc, image: _image)
          ],
        ),
      ),
    );
  }

  _buildShowBottomSheet(BuildContext context) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(MdiIcons.imageAlbum),
                title: new Text('Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: new Icon(MdiIcons.camera),
                title: new Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}

class FormAddEvent extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final EventformBloc eventformBloc;
  final File image;

  FormAddEvent({Key key, this.scaffoldKey, this.eventformBloc, this.image})
      : super(key: key);

  @override
  _FormAddEventState createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {
  var _formKey = GlobalKey<FormState>();

  var _eventNameController = TextEditingController();
  var _detailController = TextEditingController();
  var _addressController = TextEditingController();
  var _priceController = TextEditingController();
  var _ticketController = TextEditingController();
  var _takController = TextEditingController();

  String _selectedCategory = null;

  FocusNode _detailFocus = FocusNode();
  FocusNode _priceFocus = FocusNode();
  FocusNode _takFocus = FocusNode();

  String _time = 'Time';
  String _dateRange = 'Pick Date';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: widget.eventformBloc,
        builder: (context, currentState) {
          if(currentState is InEventformState){
          return Container(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomField(
                  controller: _eventNameController,
                  focusTo: _detailFocus,
                  textInputAction: TextInputAction.next,
                  label: "Event Name",
                ),
                CustomMultiField(
                    focusOwn: _detailFocus,
                    controller: _detailController,
                    label: "Detail"),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Sizing.verticalPaddingForm),
                  child: DropdownButton(
                    items: currentState.category
                        .map((String value) {
                          print(value);
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    underline: Container(color: Colors.black54, height: 1),
                    hint: Text('Select category'),
                    disabledHint: Text('Category not available'),
                    elevation: 15,
                    value: _selectedCategory,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black87,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                CustomDateTime(
                  callbackDateRange: (value) =>
                      setState(() => _dateRange = value),
                  callbackTime: (value) => setState(() => _time = value),
                ),
                CustomMultiField(
                    controller: _addressController, label: "Address"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: CustomField(
                        controller: _ticketController,
                        focusTo: _takFocus,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        label: "Available Ticket",
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomField(
                        controller: _takController,
                        focusOwn: _takFocus,
                        focusTo: _priceFocus,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        label: "TAK",
                      ),
                    ),
                  ],
                ),
                CustomField(
                  focusOwn: _priceFocus,
                  controller: _priceController,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  label: "Price",
                ),
                SizedBox(
                  height: 15,
                ),
                Align(alignment: Alignment.bottomCenter, child: btnSubmit())
              ],
            ),
          ));
          }
        });
  }

  Widget btnSubmit() {
    return BlocBuilder(
        bloc: widget.eventformBloc,
        builder: (
          BuildContext context,
          EventformState currentState,
        ) {
          if (currentState is LoadingAddEventState)
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Coloring.colorMain),
              ),
            );
          return CustomSubmitButton(
            event: () => _onSubmit(),
            icon: Icons.add_circle,
            label: 'Add Event',
          );
        });
  }

  _onSubmit() {
    var currentState = widget.eventformBloc.currentState as InEventformState;
    if (widget.image == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Image can\'t be empty'),
        duration: Duration(milliseconds: 1200),
      ));
    } else if (_time == 'Time' || _dateRange == 'Pick Date') {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick Date and Time of Event'),
        duration: Duration(milliseconds: 1500),
      ));
    } else if (_formKey.currentState.validate()) {
      widget.eventformBloc.dispatch(SubmitEventformEvent(
        currentState.user.email,
        widget.image,
        _eventNameController.text,
        _detailController.text,
        _selectedCategory,
        _time,
        _dateRange,
        _addressController.text,
        int.tryParse(_ticketController.text),
        int.tryParse(_takController.text),
        int.tryParse(_priceController.text),
      ));
    }
  }
}
