import 'dart:io';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eventell/blocs/eventform/index.dart';
import 'package:image_picker/image_picker.dart';
import 'package:eventell/Utils/utility.dart';

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

  PageController _pageController = PageController(initialPage: 0);
  File _image;

  Future getImage(source) async {
    var image = await ImagePicker.pickImage(
        source: source, maxHeight: 720, maxWidth: 1280);

    setState(() {
      _image = image;
    });
  }

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
    return BlocBuilder<EventformEvent, EventformState>(
        bloc: widget._eventformBloc,
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

          return PageView(
            controller: _pageController,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.grey)),
                        child: Center(
                          child: _image == null
                              ? Text('No image selected.')
                              : Image.file(_image),
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
                    Form_1(
                      pageController: _pageController,
                    )
                  ],
                ),
              ),
              Container(
                  child: new Center(
                child: new Text("Page 2"),
              )),
            ],
          );
        });
  }
}

class Form_1 extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController pageController;

  Form_1({Key key, this.scaffoldKey, this.pageController}) : super(key: key);

  @override
  _Form_1State createState() => _Form_1State();
}

class _Form_1State extends State<Form_1> {
  var _formKey = GlobalKey<FormState>();

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  int _selectedCategory = 0;
  int _selectedOrganization = 0;

  FocusNode _descriptionFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(Sizing.paddingContent),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(Sizing.borderRadiusFormText),
              shadowColor: Colors.black54,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: _titleController,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(233, 233, 233, 1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(Sizing.borderRadiusFormText),
                  ),
                  contentPadding: EdgeInsets.all(15.0),
                  labelText: 'Title',
                ),
                validator: ((val) {
                  if (val.isEmpty) return 'Fill the title field';
                }),
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(Sizing.borderRadiusFormText),
              shadowColor: Colors.black54,
              child: TextFormField(
                maxLines: 5,
                minLines: 1,
                focusNode: _descriptionFocus,
                controller: _descriptionController,
                decoration: InputDecoration(
                  fillColor: Color.fromRGBO(233, 233, 233, 1),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(Sizing.borderRadiusFormText))),
                  contentPadding: EdgeInsets.all(15.0),
                  labelText: 'Description',
                ),
                validator: (val) {
                  if (val.isEmpty) return 'Fill the description field';
                },
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Material(
              elevation: 2,
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                    hint: Text('Select category'),
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
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Material(
              elevation: 2,
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton(
                    hint: Text('Select organization'),
                    elevation: 10,
                    value: _selectedOrganization,
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black87,
                    ),
                    items: <DropdownMenuItem>[
                      DropdownMenuItem(
                        value: 0,
                        child: Text('Organization 1'),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text('Organization 2'),
                      )
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedOrganization = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Align(alignment: Alignment.bottomCenter, child: btnNext())
          ],
        ),
      ),
    ));
  }

  Widget btnNext() {
    return Material(
      elevation: 10,
      shadowColor: Colors.black87,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: FlatButton.icon(
            color: Coloring.colorLogin,
            icon: Icon(
              MdiIcons.pageNext,
              color: Coloring.colorLoginText,
            ),
            onPressed: _onLogin,
            label: Text(
              'NEXT',
              style: TextStyle(color: Coloring.colorLoginText),
            )),
      ),
    );
  }

  void _onLogin() {
    if (_formKey.currentState.validate()) {
      _descriptionFocus.unfocus();
      widget.pageController.nextPage(
          curve: Curves.easeInOut, duration: Duration(milliseconds: 400));
    }
  }
}
