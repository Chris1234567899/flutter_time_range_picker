import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Range Picker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Time Range Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          RaisedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
              );
              print("result " + result.toString());
            },
            child: Text("Pure"),
          ),
          RaisedButton(
            onPressed: () {
              showTimeRangePicker(
                context: context,
                start: TimeOfDay(hour: 22,minute: 9),
                onStartChange: (start) {
                  print("start time " + start.toString());
                },
                onEndChange: (end) {
                  print("end time " + end.toString());
                },
                interval: Duration(minutes: 30),
                use24HourFormat: true,
                padding: 30,
                strokeWidth: 20,
                handlerRadius: 14,
                strokeColor: Colors.orange,
                handlerColor: Colors.orange[700],
                selectedColor: Colors.amber,
                backgroundColor: Colors.black.withOpacity(0.3),
                ticks: 12,
                ticksColor: Colors.white,
                snap: true,
                labels: [
                  "12 pm",
                  "3 am",
                  "6 am",
                  "9 am",
                  "12 am",
                  "3 pm",
                  "6 pm",
                  "9 pm"
                ].asMap().entries.map((e) {
                  return ClockLabel.fromIndex(
                      idx: e.key, length: 8, text: e.value);
                }).toList(),
                labelOffset: -30,
                labelStyle: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
                timeTextStyle: TextStyle(
                    color: Colors.orange[700],
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
                activeTimeTextStyle: TextStyle(
                    color: Colors.orange,
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              );
            },
            child: Text("Interval"),
          ),
          RaisedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                  context: context,
                  start: TimeOfDay(hour: 9, minute: 0),
                  end: TimeOfDay(hour: 12, minute: 0),
                  disabledTime: TimeRange(
                      startTime: TimeOfDay(hour: 22, minute: 0),
                      endTime: TimeOfDay(hour: 5, minute: 0)),
                  disabledColor: Colors.red.withOpacity(0.5),
                  strokeWidth: 4,
                  ticks: 24,
                  ticksOffset: -7,
                  ticksLength: 15,
                  ticksColor: Colors.grey,
                  labels: [
                    "12 pm",
                    "3 am",
                    "6 am",
                    "9 am",
                    "12 am",
                    "3 pm",
                    "6 pm",
                    "9 pm"
                  ].asMap().entries.map((e) {
                    return ClockLabel.fromIndex(
                        idx: e.key, length: 8, text: e.value);
                  }).toList(),
                  labelOffset: 35,
                  rotateLabels: false,
                  padding: 60);

              print("result " + result.toString());
            },
            child: Text("Disabled Times"),
          ),
          RaisedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
                paintingStyle: PaintingStyle.fill,
                backgroundColor: Colors.grey.withOpacity(0.2),
                labels: [
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 7, minute: 0), text: "Start Work"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 18, minute: 0), text: "Go Home")
                ],
                start: TimeOfDay(hour: 10, minute: 0),
                end: TimeOfDay(hour: 13, minute: 0),
                ticks: 8,
                strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
                ticksColor: Theme.of(context).primaryColor,
                labelOffset: 15,
                padding: 60,
                disabledTime: TimeRange(
                    startTime: TimeOfDay(hour: 18, minute: 0),
                    endTime: TimeOfDay(hour: 7, minute: 0)),
                disabledColor: Colors.red.withOpacity(0.5),
              );

              print("result " + result.toString());
            },
            child: Text("Filled Style"),
          ),
          RaisedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
                strokeColor: Colors.teal,
                handlerColor: Colors.teal[200],
                selectedColor: Colors.tealAccent,
                strokeWidth: 16,
                handlerRadius: 18,
                backgroundWidget: Image.asset(
                  "assets/images/day-night.png",
                  height: 200,
                  width: 200,
                ),
                labels: [
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 6, minute: 0), text: "Get up"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 9, minute: 0), text: "Coffee time"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 15, minute: 0), text: "Afternoon"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 18, minute: 0),
                      text: "Time for a beer"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 22, minute: 0),
                      text: "Go to Sleep"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 2, minute: 0),
                      text: "Go for a pee"),
                  ClockLabel.fromTime(
                      time: TimeOfDay(hour: 12, minute: 0), text: "Lunchtime!")
                ],
                ticksColor: Colors.black,
                labelOffset: 40,
                padding: 55,
                labelStyle: TextStyle(fontSize: 18, color: Colors.black),
              );

              print("result " + result.toString());
            },
            child: Text("Background Widget"),
          ),
        ]),
      ),
    );
  }
}
