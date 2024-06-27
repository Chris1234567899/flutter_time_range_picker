import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';

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
  MyHomePage({Key? key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView(children: [
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
            );

            print("result " + result.toString());
          },
          child: Text("Pure"),
        ),
        ElevatedButton(
          onPressed: () {
            showTimeRangePicker(
              context: context,
              start: TimeOfDay(hour: 22, minute: 9),
              onStartChange: (start) {
                print("start time " + start.toString());
              },
              onEndChange: (end) {
                print("end time " + end.toString());
              },
              interval: Duration(hours: 1),
              minDuration: Duration(hours: 1),
              use24HourFormat: false,
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
              labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
                  .asMap()
                  .entries
                  .map((e) {
                return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              labelStyle: TextStyle(fontSize: 22, color: Colors.grey, fontWeight: FontWeight.bold),
              timeTextStyle: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
              activeTimeTextStyle: TextStyle(
                  color: Colors.orange,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            );
          },
          child: Text("Interval"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
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
                labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
                    .asMap()
                    .entries
                    .map((e) {
                  return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
                }).toList(),
                labelOffset: 35,
                rotateLabels: false,
                padding: 60);

            print("result " + result.toString());
          },
          child: Text("Disabled Times"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              paintingStyle: PaintingStyle.fill,
              backgroundColor: Colors.grey.withOpacity(0.2),
              labels: [
                ClockLabel.fromTime(time: TimeOfDay(hour: 7, minute: 0), text: "Start Work"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 18, minute: 0), text: "Go Home")
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
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
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
                ClockLabel.fromTime(time: TimeOfDay(hour: 6, minute: 0), text: "Get up"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 9, minute: 0), text: "Coffee time"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 15, minute: 0), text: "Afternoon"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 18, minute: 0), text: "Time for a beer"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 22, minute: 0), text: "Go to Sleep"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 2, minute: 0), text: "Go for a pee"),
                ClockLabel.fromTime(time: TimeOfDay(hour: 12, minute: 0), text: "Lunchtime!")
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
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              strokeWidth: 4,
              ticks: 12,
              ticksOffset: 2,
              ticksLength: 8,
              handlerRadius: 8,
              ticksColor: Colors.grey,
              rotateLabels: false,
              labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
                  .asMap()
                  .entries
                  .map((e) {
                return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: 30,
              padding: 55,
              labelStyle: TextStyle(fontSize: 18, color: Colors.black),
              start: TimeOfDay(hour: 12, minute: 0),
              end: TimeOfDay(hour: 15, minute: 0),
              disabledTime: TimeRange(
                  startTime: TimeOfDay(hour: 6, minute: 0),
                  endTime: TimeOfDay(hour: 10, minute: 0)),
              clockRotation: 180.0,
            );

            print("result " + result.toString());
          },
          child: Text("Rotated Clock"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              rotateLabels: false,
              ticks: 12,
              ticksColor: Colors.grey,
              ticksOffset: -12,
              labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
                  .asMap()
                  .entries
                  .map((e) {
                return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              padding: 55,
              start: TimeOfDay(hour: 12, minute: 0),
              end: TimeOfDay(hour: 18, minute: 0),
              disabledTime: TimeRange(
                startTime: TimeOfDay(hour: 4, minute: 0),
                endTime: TimeOfDay(hour: 10, minute: 0),
              ),
              maxDuration: Duration(hours: 6),
            );

            print("result " + result.toString());
          },
          child: Text("Max duration"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              rotateLabels: false,
              ticks: 12,
              ticksColor: Colors.grey,
              ticksOffset: -12,
              labels: ["24 h", "3 h", "6 h", "9 h", "12 h", "15 h", "18 h", "21 h"]
                  .asMap()
                  .entries
                  .map((e) {
                return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              padding: 55,
              start: TimeOfDay(hour: 12, minute: 0),
              end: TimeOfDay(hour: 18, minute: 0),
              disabledTime: TimeRange(
                startTime: TimeOfDay(hour: 4, minute: 0),
                endTime: TimeOfDay(hour: 10, minute: 0),
              ),
              minDuration: Duration(hours: 3),
            );

            print("result " + result.toString());
          },
          child: Text("Min duration"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result =
                await showTimeRangePicker(context: context, barrierDismissible: false);

            print("result " + result.toString());
          },
          child: Text("No barrier dismissable"),
        ),
        Divider(),
        Text(
          'As a regular widget:',
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        Container(
          padding: EdgeInsets.all(20),
          height: 400,
          child: TimeRangePicker(
            hideButtons: true,
            hideTimes: true,
            paintingStyle: PaintingStyle.fill,
            backgroundColor: Colors.grey.withOpacity(0.2),
            labels: [
              ClockLabel.fromTime(time: TimeOfDay(hour: 7, minute: 0), text: "Start Work"),
              ClockLabel.fromTime(time: TimeOfDay(hour: 18, minute: 0), text: "Go Home")
            ],
            start: TimeOfDay(hour: 10, minute: 0),
            end: TimeOfDay(hour: 13, minute: 0),
            ticks: 8,
            strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
            ticksColor: Theme.of(context).primaryColor,
            labelOffset: 15,
            padding: 60,
            disabledTime: TimeRange(
                startTime: TimeOfDay(hour: 18, minute: 0), endTime: TimeOfDay(hour: 7, minute: 0)),
            disabledColor: Colors.red.withOpacity(0.5),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                TimeOfDay _startTime = TimeOfDay.now();
                TimeOfDay _endTime = TimeOfDay.now();
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Choose a nice timeframe"),
                  content: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: TimeRangePicker(
                      hideButtons: true,
                      onStartChange: (start) {
                        setState(() {
                          _startTime = start;
                        });
                      },
                      onEndChange: (end) {
                        setState(() {
                          _endTime = end;
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: Text('My custom cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: Text('My custom ok'),
                      onPressed: () {
                        Navigator.of(context)
                            .pop(TimeRange(startTime: _startTime, endTime: _endTime));
                      },
                    ),
                  ],
                );
              },
            );

            print(result.toString());
          },
          child: Text("Custom Dialog"),
        ),
        ElevatedButton(
            onPressed: () async {
              TimeRange? result = await showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  TimeOfDay _startTime = TimeOfDay.now();
                  TimeOfDay _endTime = TimeOfDay.now();
                  return CupertinoAlertDialog(
                    content: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 340,
                        child: Column(
                          children: [
                            TimeRangePicker(
                              padding: 22,
                              hideButtons: true,
                              handlerRadius: 8,
                              strokeWidth: 4,
                              ticks: 12,
                              activeTimeTextStyle: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 22, color: Colors.white),
                              timeTextStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: Colors.white70),
                              onStartChange: (start) {
                                setState(() {
                                  _startTime = start;
                                });
                              },
                              onEndChange: (end) {
                                setState(() {
                                  _endTime = end;
                                });
                              },
                            ),
                          ],
                        )),
                    actions: <Widget>[
                      CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoDialogAction(
                        child: Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop(
                            TimeRange(startTime: _startTime, endTime: _endTime),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
              print(result.toString());
            },
            child: Text("Cupertino style"))
      ]),
    );
  }
}
