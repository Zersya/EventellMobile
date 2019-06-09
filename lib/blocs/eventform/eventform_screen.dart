import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eventell/blocs/eventform/eventform_state.dart';
import 'package:eventell/widgets/SuccessDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/CustomMultiField.dart';
import 'package:eventell/widgets/CustomField.dart';
import 'package:eventell/widgets/CustomDateTime.dart';
import 'package:eventell/widgets/CustomSubmitButton.dart';

class EventformScreen extends StatefulWidget {
  const EventformScreen({
    Key key,
    this.dataEdit,
  }) : super(key: key);
  final dataEdit;

  @override
  EventformScreenState createState() {
    return new EventformScreenState();
  }
}

class EventformScreenState extends State<EventformScreen> {
  EventformBloc _eventformBloc;

  @override
  void initState() {
    super.initState();
    _eventformBloc = new EventformBloc();

    var dataEdit = widget.dataEdit;

    _eventformBloc
        .dispatch(LoadEventformEvent(dataEdit != null ? dataEdit : null));
  }

  @override
  void dispose() {
    super.dispose();
    _eventformBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _eventformBloc,
      listener: (BuildContext context, EventformState currentState) {
        if (currentState is AddedState) {
          _eventformBloc.dispatch(LoadEventformEvent(
              widget.dataEdit != null ? widget.dataEdit : null));
          _successDialog(context);
        }
      },
      child: BlocBuilder<EventformEvent, EventformState>(
          bloc: _eventformBloc,
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
            return BlocProvider<EventformBloc>(
              bloc: _eventformBloc,
              child: ScreenForm(dataEdit: widget.dataEdit),
            );
          }),
    );
  }

  Future _successDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).popUntil(ModalRoute.withName('/mainPage'));
          },
          child: SuccessDialog(word: widget.dataEdit != null ?
              StringWord.eventSuccessEdited :
              StringWord.eventSuccessAdded,)
        );
      },
    );
  }
}

class ScreenForm extends StatefulWidget {
  final dataEdit;

  const ScreenForm({Key key, this.dataEdit}) : super(key: key);
  @override
  _ScreenFormState createState() => _ScreenFormState();
}

class _ScreenFormState extends State<ScreenForm> {
  File _image;
  var _eventformBloc;

  String _curImageUrl = null;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
    _eventformBloc = BlocProvider.of<EventformBloc>(context);

    _isEdit = (_eventformBloc.currentState.dataEdit != null);
    if(_isEdit)
      _curImageUrl = _eventformBloc.currentState.dataEdit['eventImage'];
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
                child: conditionImage(),
              ),
              onTap: () => _buildShowBottomSheet(context),
            ),
            SizedBox(
              height: 20,
            ),
            FormAddEvent(
                image: _image, isEdit: _isEdit, dataEdit: widget.dataEdit),
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

  Widget conditionImage() {
    if (_image == null && _isEdit)
      return CachedNetworkImage(
        fit: BoxFit.cover,
        height: 100,
        imageUrl: _curImageUrl,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
      );
    if (_image == null) {
      return Align(
        child: Text(
          'Add your poster',
        ),
        alignment: Alignment.center,
      );
    } else {
      return Image.file(
        _image,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      );
    }
  }
}

class FormAddEvent extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final File image;
  final bool isEdit;
  final dataEdit;

  FormAddEvent(
      {Key key, this.scaffoldKey, this.image, this.isEdit, this.dataEdit})
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
  var _eventformBloc;
  String _selectedCategory;
  List _category = new List();
  FocusNode _detailFocus = FocusNode();
  FocusNode _priceFocus = FocusNode();
  FocusNode _takFocus = FocusNode();

  String _time = 'Time';
  String _dateRange = 'Pick Date';
  @override
  void initState() {
    super.initState();
    _eventformBloc = BlocProvider.of<EventformBloc>(context);

    _selectedCategory = null;
    if (_eventformBloc.currentState is InEventformState) {
      var _curState = _eventformBloc.currentState;
      _category = _curState.category.map((v) => v).toList();

      if (_curState.dataEdit != null) {
        _eventNameController.text = _curState.dataEdit['eventName'];
        _detailController.text = _curState.dataEdit['eventDetail'];
        _addressController.text = _curState.dataEdit['eventAddress'];
        _priceController.text = _curState.dataEdit['eventPrice'].toString();
        _ticketController.text =
            _curState.dataEdit['eventAvaTicket'].toString();
        _takController.text = _curState.dataEdit['eventTak'].toString();

        _selectedCategory = _curState.dataEdit['eventCategory'];
        _time = _curState.dataEdit['eventTime'];
        _dateRange = _curState.dataEdit['eventDate'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
              items: _category.map((value) {
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
            date: _dateRange,
            time: _time,
            callbackDateRange: (value) => setState(() => _dateRange = value),
            callbackTime: (value) => setState(() => _time = value),
          ),
          CustomMultiField(controller: _addressController, label: "Address"),
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

  Widget btnSubmit() {
    if (_eventformBloc.currentState is LoadingAddEventState)
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Coloring.colorMain),
        ),
      );

    if (_eventformBloc.currentState is InEventformState) {
      var dataEdit = _eventformBloc.currentState.dataEdit;
      if (dataEdit != null) {
        return CustomSubmitButton(
          event: () => _onSubmit(),
          icon: Icons.add_circle,
          label: 'Edit Event',
        );
      }
    }
    return CustomSubmitButton(
      event: () => _onSubmit(),
      icon: Icons.add_circle,
      label: 'Add Event',
    );
  }

  _onSubmit() {
    var currentState = _eventformBloc.currentState as InEventformState;

    if (widget.image == null && currentState.dataEdit['eventImage'] == null) {
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
      _eventformBloc.dispatch(SubmitEventformEvent(
        widget.isEdit,
        widget.dataEdit,
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
