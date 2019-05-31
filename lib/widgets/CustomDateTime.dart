import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

typedef void StringCallbackTime(String time);
typedef void StringCallbackDateRange(String dateRange);

class CustomDateTime extends StatefulWidget {
  const CustomDateTime({Key key, this.callbackTime, this.callbackDateRange, this.time, this.date})
      : super(key: key);

  final StringCallbackTime callbackTime;
  final StringCallbackDateRange callbackDateRange;
  final String time, date;

  @override
  _CustomDateTimeState createState() => _CustomDateTimeState();
}

class _CustomDateTimeState extends State<CustomDateTime> {
  String _time;
  String _dateRange;

  @override
  void initState() {
    super.initState();
    _dateRange = widget.date != null ? widget.date :  "Pick Date";
    _time = widget.time != null ? widget.time : "Pick Time";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton.icon(
            icon: Icon(Icons.access_time),
            onPressed: () {
              DatePicker.showTimePicker(context, showTitleActions: true,
                  onChanged: (date) {
              }, onConfirm: (date) {
                setState(() {
                  _time = date.hour.toString() + ":" + date.minute.toString();
                  widget.callbackTime(_time);
                });
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
                  widget.callbackDateRange(_dateRange);
                });
              } else if (picked != null && picked.length == 1) {
                String first = picked.first.day.toString() +
                    "/" +
                    picked.first.month.toString() +
                    "/" +
                    picked.first.year.toString();

                setState(() {
                  _dateRange = first;
                  widget.callbackDateRange(_dateRange);
                });
              }
            },
            label: Text(
              _dateRange,
              style: TextStyle(color: Colors.blue),
            )),
      ],
    );
  }
}
