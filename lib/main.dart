import 'package:calendar/CustomShowDialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:intl/intl.dart' show DateFormat;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'dooboolab flutter calendar',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Calendar Carousel Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _currentDate = DateTime(2019, 1, 3);
  DateTime _currentDate2 = DateTime(2019, 1, 3);

DateTime _initialDate = DateTime(2018,1,1);
  DateTime _finishDate = DateTime.now();

  String _currentMonth = '';
  String _dateselected = null;
  var formatter = DateFormat('dd/MM/yyyy');

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate2 = date) ;
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
      weekFormat: false,
      height: 420.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      markedDateMoreShowTotal:
          false, // null for not showing hidden events indicator
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      minSelectedDate: _initialDate,
      maxSelectedDate: _finishDate,
      onCalendarChanged: (DateTime date) {
        var formatter = new DateFormat("MMMM", 'es_PE');
        this.setState(() => _currentMonth = formatter.format(date));
      },
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //custom icon without header
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: new Row(
                  children: <Widget>[
                    FlatButton(
                      child: Text('Anterior'),
                      onPressed: () {
                        setState(() {
                          _currentDate2 =
                              _currentDate2.subtract(Duration(days: 30));
                              var formatter = new DateFormat("MMMM", 'es_PE');
                          _currentMonth =
                              formatter.format(_currentDate2);
                        });
                      },
                    ),
                           Expanded(
                        child: Text(
                      _currentMonth.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    FlatButton(
                      child: Text('Siguiente'),
                      onPressed: () {
                        setState(() {
                          _currentDate2 = _currentDate2.add(Duration(days: 30));
                          var formatter = new DateFormat("MMMM", 'es_PE');
                          _currentMonth =
                              formatter.format(_currentDate2);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarouselNoHeader,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new FlatButton(
                    child: Text('Cancelar',style: TextStyle(fontSize: 18.0)), onPressed: () {},
                  ),
                  ),
                  new Expanded(
                    flex: 1,
                    child:  new FlatButton(
                    child: Text('Aceptar',style: TextStyle(fontSize: 18.0)), onPressed: () {},
                  )
                  )
                ],
              ),
              new Text(formatter.format(_currentDate2)) //
            ],
          ),
        ));
  }
}