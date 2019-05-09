import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:eventell/Utils/utility.dart';
import 'package:eventell/widgets/CustomMultiField.dart';
import 'package:eventell/widgets/CustomField.dart';

class ScreenForm extends StatefulWidget {
  const ScreenForm({
    Key key,
    this.pageController,
  }) : super(key: key);

  final PageController pageController;
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
              onTap: () {
                showBottomSheet(
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
              },
            ),
            SizedBox(
              height: 20,
            ),
            FormAddEvent(
              pageController: widget.pageController,
            )
          ],
        ),
      ),
    );
  }
}

class FormAddEvent extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController pageController;

  FormAddEvent({Key key, this.scaffoldKey, this.pageController}) : super(key: key);

  @override
  _FormAddEventState createState() => _FormAddEventState();
}

class _FormAddEventState extends State<FormAddEvent> {
  var _formKey = GlobalKey<FormState>();

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _addressController = TextEditingController();
  var _priceController = TextEditingController();
  var _ticketController = TextEditingController();
  var _takController = TextEditingController();

  int _selectedCategory = 0;

  FocusNode _descriptionFocus = FocusNode();
  FocusNode _priceFocus = FocusNode();
  FocusNode _ticketFocus = FocusNode();
  FocusNode _takFocus = FocusNode();

  String _time = 'Time';
  String _dateRange = 'Pick Date';

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
            controller: _titleController,
            focusTo: _descriptionFocus,
            textInputAction: TextInputAction.next,
            label: "Event Name",
          ),
          CustomMultiField(
              focusOwn: _descriptionFocus,
              controller: _descriptionController,
              label: "Detail"),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Sizing.verticalPaddingForm),
            child: DropdownButton(
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
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  value: 0,
                  child: Text('Category 1'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Category 2'),
                )
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton.icon(
                  icon: Icon(Icons.access_time),
                  onPressed: () {
                    DatePicker.showTimePicker(context, showTitleActions: true,
                        onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        _time =
                            date.hour.toString() + ":" + date.minute.toString();
                      });
                      print('confirm $_time');
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  label: Text(
                    _time,
                    style: TextStyle(color: Colors.blue),
                  )),
              FlatButton.icon(
                  icon: Icon(Icons.date_range),
                  onPressed: () async {
                    final List<DateTime> picked =
                        await DateRangePicker.showDatePicker(
                            context: context,
                            initialFirstDate: new DateTime.now(),
                            initialLastDate:
                                (new DateTime.now()).add(new Duration(days: 3)),
                            firstDate: new DateTime(2015),
                            lastDate: new DateTime(2020));
                    if (picked != null && picked.length == 2) {
                      print(picked);
                      String first = picked.first.day.toString() +
                          "/" +
                          picked.first.month.toString() +
                          "/" +
                          picked.first.year.toString();
                      String last = picked.last.day.toString() +
                          "/" +
                          picked.last.month.toString() +
                          "/" +
                          picked.last.year.toString();

                      setState(() {
                        _dateRange = first + " - " + last;
                      });
                    } else if (picked != null && picked.length == 1) {
                      String first = picked.first.day.toString() +
                          "/" +
                          picked.first.month.toString() +
                          "/" +
                          picked.first.year.toString();

                      setState(() {
                        _dateRange = first;
                      });
                    }
                  },
                  label: Text(
                    _dateRange,
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
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
          Align(alignment: Alignment.bottomCenter, child: btnNext())
        ],
      ),
    ));
  }

  Widget btnNext() {
    return Material(
      elevation: 3,
      shadowColor: Colors.black87,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: FlatButton.icon(
            color: Coloring.colorMain,
            icon: Icon(
              Icons.add_circle,
              color: Coloring.colorLoginText,
            ),
            onPressed: _onNext,
            label: Text(
              'Add Event',
              style: TextStyle(
                  color: Coloring.colorLoginText, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }

  void _onNext() {
    if (_formKey.currentState.validate()) {
      _descriptionFocus.unfocus();
      widget.pageController.nextPage(
          curve: Curves.easeInOut, duration: Duration(milliseconds: 400));
    }
  }
}
