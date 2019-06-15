import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventell/blocs/filter/filter_bloc.dart';
import 'package:eventell/shared/utility.dart';
import 'package:eventell/widgets/ListEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'filter_bloc.dart';

class FilterEventPage extends StatelessWidget {
  final data;

  const FilterEventPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int initIndex = 0;
    var name = data[0];
    var category = data[1];

    if(category == null && name != null) initIndex = 0;
    else if(name == null && category != null) initIndex = 1;
    else initIndex = 0;
    return DefaultTabController(
      length: 2,
      initialIndex: initIndex,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Event"),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            tabs: [
              Tab(
                child: Text("Name"),
              ),
              Tab(child: Text("Category")),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TabBarView(

            children: <Widget>[
              Tab1(
                name: name,
              ),
              Tab2(
                category: category,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Tab1 extends StatefulWidget {
  final name;

  const Tab1({Key key, this.name}) : super(key: key);
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  FilterBloc _filterBloc = FilterBloc();
  TextEditingController _controllerText = TextEditingController();
  @override
  void initState() {
    _filterBloc.dispatch(LoadFiltereventEvent(name: widget.name));
    _controllerText.text = widget.name;
    super.initState();
  }

  @override
  void dispose() {
    _filterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltereventEvent, FiltereventState>(
      bloc: _filterBloc,
      builder: (context, currentState) {
        if (currentState is InFiltereventState) {
          return MultiProvider(
              providers: [
                StreamProvider<QuerySnapshot>.value(
                  value: currentState.streamEvent,
                ),
                StreamProvider<DocumentSnapshot>.value(
                  value: currentState.streamUser,
                ),
              ],
              child: Column(
                children: <Widget>[
                  Container(
                    child: TextFormField(
                      controller: _controllerText,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: StringWord.hintSearch,
                          contentPadding: EdgeInsets.all(15.0),
                          filled: true,
                          fillColor: Colors.grey[300],
                          suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: (){
                            setState(() {
                              _filterBloc.dispatch(LoadFiltereventEvent(name: _controllerText.text));
                            });
                          },)),
                    ),
                  ),
                  Divider(height: 50,),
                  ListEvent(
                    isShowPaidButton: false,
                    isDetailEvent: true,
                    isDetailTicket: false,
                  ),
                ],
              ));
        }
        return Center(
            child: SpinKitCubeGrid(
          color: Coloring.colorMain,
        ));
      },
    );
  }
}

class Tab2 extends StatefulWidget {
  final category;

  const Tab2({Key key, this.category}) : super(key: key);
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  FilterBloc _filterBloc = FilterBloc();
  String _selectedCategory;

  @override
  void initState() {
    _filterBloc.dispatch(LoadFiltereventEvent(category: widget.category));
    _selectedCategory = widget.category;
    super.initState();
  }

  @override
  void dispose() {
    _filterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltereventEvent, FiltereventState>(
      bloc: _filterBloc,
      builder: (context, currentState) {
        if (currentState is InFiltereventState) {
          return MultiProvider(
              providers: [
                StreamProvider<QuerySnapshot>.value(
                  value: currentState.streamEvent,
                ),
                StreamProvider<DocumentSnapshot>.value(
                  value: currentState.streamUser,
                ),
              ],
              child: Column(
                children: <Widget>[
                  StreamProvider<DocumentSnapshot>.value(
                    value: currentState.streamCategory,
                    child: DropDownCategory(
                      onChange: (value) {
                        _filterBloc.dispatch(LoadFiltereventEvent(category:value));

                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      selectedCategory: _selectedCategory,
                    ),
                  ),
                  Divider(height: 50,),
                  ListEvent(
                    isShowPaidButton: false,
                    isDetailEvent: true,
                    isDetailTicket: false,
                  ),
                ],
              ));
        }
        return Center(
            child: SpinKitCubeGrid(
          color: Coloring.colorMain,
        ));
      },
    );
  }
}

class DropDownCategory extends StatelessWidget {
  final selectedCategory, onChange;

  const DropDownCategory({Key key, this.selectedCategory, this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    DocumentSnapshot _snapshotCat = Provider.of<DocumentSnapshot>(context);
    if (_snapshotCat == null) return Container();
    List _category =_snapshotCat.data['list'];
    return Container(
      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal:10.0),
      child: DropdownButton(
          items: _category.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
          hint: Text('Select category'),
          disabledHint: Text('Category not available'),
          elevation: 15,
          value: selectedCategory,
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black87,
          ),
          onChanged: this.onChange),
    );
  }
}
