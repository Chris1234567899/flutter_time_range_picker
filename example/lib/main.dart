import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      ),
      home: const MyHomePage(title: 'Flutter Time Range Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Pure"),
        ),
        ElevatedButton(
          onPressed: () {
            showTimeRangePicker(
              context: context,
              start: const TimeOfDay(hour: 22, minute: 9),
              onStartChange: (start) {
                if (kDebugMode) {
                  print("start time $start");
                }
              },
              onEndChange: (end) {
                if (kDebugMode) {
                  print("end time $end");
                }
              },
              interval: const Duration(hours: 1),
              minDuration: const Duration(hours: 1),
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
              labels: [
                "12 am",
                "3 am",
                "6 am",
                "9 am",
                "12 pm",
                "3 pm",
                "6 pm",
                "9 pm"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              labelStyle: const TextStyle(
                  fontSize: 22,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
              timeTextStyle: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
              activeTimeTextStyle: const TextStyle(
                  color: Colors.orange,
                  fontSize: 26,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold),
            );
          },
          child: const Text("Interval"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
                context: context,
                start: const TimeOfDay(hour: 9, minute: 0),
                end: const TimeOfDay(hour: 12, minute: 0),
                disabledTime: TimeRange(
                    startTime: const TimeOfDay(hour: 22, minute: 0),
                    endTime: const TimeOfDay(hour: 5, minute: 0)),
                disabledColor: Colors.red.withOpacity(0.5),
                strokeWidth: 4,
                ticks: 24,
                ticksOffset: -7,
                ticksLength: 15,
                ticksColor: Colors.grey,
                labels: [
                  "12 am",
                  "3 am",
                  "6 am",
                  "9 am",
                  "12 pm",
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

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Disabled Times"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              paintingStyle: PaintingStyle.fill,
              backgroundColor: Colors.grey.withOpacity(0.2),
              labels: [
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 7, minute: 0),
                    text: "Start Work"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 18, minute: 0), text: "Go Home")
              ],
              start: const TimeOfDay(hour: 10, minute: 0),
              end: const TimeOfDay(hour: 13, minute: 0),
              ticks: 8,
              strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
              ticksColor: Theme.of(context).primaryColor,
              labelOffset: 15,
              padding: 60,
              disabledTime: TimeRange(
                  startTime: const TimeOfDay(hour: 18, minute: 0),
                  endTime: const TimeOfDay(hour: 7, minute: 0)),
              disabledColor: Colors.red.withOpacity(0.5),
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Filled Style"),
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
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 6, minute: 0), text: "Get up"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 9, minute: 0),
                    text: "Coffee time"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 15, minute: 0),
                    text: "Afternoon"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 18, minute: 0),
                    text: "Time for a beer"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 22, minute: 0),
                    text: "Go to Sleep"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 2, minute: 0),
                    text: "Go for a pee"),
                ClockLabel.fromTime(
                    time: const TimeOfDay(hour: 12, minute: 0),
                    text: "Lunchtime!")
              ],
              ticksColor: Colors.black,
              labelOffset: 40,
              padding: 55,
              labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Background Widget"),
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
              labels: [
                "24 h",
                "3 h",
                "6 h",
                "9 h",
                "12 h",
                "15 h",
                "18 h",
                "21 h"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: 30,
              padding: 55,
              labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
              start: const TimeOfDay(hour: 12, minute: 0),
              end: const TimeOfDay(hour: 15, minute: 0),
              disabledTime: TimeRange(
                  startTime: const TimeOfDay(hour: 6, minute: 0),
                  endTime: const TimeOfDay(hour: 10, minute: 0)),
              clockRotation: 180.0,
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Rotated Clock"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              rotateLabels: false,
              ticks: 12,
              ticksColor: Colors.grey,
              ticksOffset: -12,
              labels: [
                "24 h",
                "3 h",
                "6 h",
                "9 h",
                "12 h",
                "15 h",
                "18 h",
                "21 h"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              padding: 55,
              start: const TimeOfDay(hour: 12, minute: 0),
              end: const TimeOfDay(hour: 18, minute: 0),
              disabledTime: TimeRange(
                startTime: const TimeOfDay(hour: 4, minute: 0),
                endTime: const TimeOfDay(hour: 10, minute: 0),
              ),
              maxDuration: const Duration(hours: 6),
            );

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Max duration"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
              context: context,
              rotateLabels: false,
              ticks: 12,
              ticksColor: Colors.grey,
              ticksOffset: -12,
              labels: [
                "24 h",
                "3 h",
                "6 h",
                "9 h",
                "12 h",
                "15 h",
                "18 h",
                "21 h"
              ].asMap().entries.map((e) {
                return ClockLabel.fromIndex(
                    idx: e.key, length: 8, text: e.value);
              }).toList(),
              labelOffset: -30,
              padding: 55,
              start: const TimeOfDay(hour: 12, minute: 0),
              end: const TimeOfDay(hour: 18, minute: 0),
              disabledTime: TimeRange(
                startTime: const TimeOfDay(hour: 4, minute: 0),
                endTime: const TimeOfDay(hour: 10, minute: 0),
              ),
              minDuration: const Duration(hours: 3),
            );
            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("Min duration"),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showTimeRangePicker(
                context: context, barrierDismissible: false);

            if (kDebugMode) {
              print("result $result");
            }
          },
          child: const Text("No barrier dismissable"),
        ),
        const Divider(),
        Text(
          'As a regular widget:',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        Container(
          padding: const EdgeInsets.all(20),
          height: 400,
          child: TimeRangePicker(
            hideButtons: true,
            hideTimes: true,
            paintingStyle: PaintingStyle.fill,
            backgroundColor: Colors.grey.withOpacity(0.2),
            labels: [
              ClockLabel.fromTime(
                  time: const TimeOfDay(hour: 7, minute: 0),
                  text: "Start Work"),
              ClockLabel.fromTime(
                  time: const TimeOfDay(hour: 18, minute: 0), text: "Go Home")
            ],
            start: const TimeOfDay(hour: 10, minute: 0),
            end: const TimeOfDay(hour: 13, minute: 0),
            ticks: 8,
            strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
            ticksColor: Theme.of(context).primaryColor,
            labelOffset: 15,
            padding: 60,
            disabledTime: TimeRange(
                startTime: const TimeOfDay(hour: 18, minute: 0),
                endTime: const TimeOfDay(hour: 7, minute: 0)),
            disabledColor: Colors.red.withOpacity(0.5),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            TimeRange? result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                TimeOfDay startTime = TimeOfDay.now();
                TimeOfDay endTime = TimeOfDay.now();
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  title: const Text("Choose a nice timeframe"),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 450,
                    child: TimeRangePicker(
                      hideButtons: true,
                      onStartChange: (start) {
                        setState(() {
                          startTime = start;
                        });
                      },
                      onEndChange: (end) {
                        setState(() {
                          endTime = end;
                        });
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        child: const Text('My custom cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    TextButton(
                      child: const Text('My custom ok'),
                      onPressed: () {
                        Navigator.of(context).pop(
                            TimeRange(startTime: startTime, endTime: endTime));
                      },
                    ),
                  ],
                );
              },
            );

            if (kDebugMode) {
              print(result.toString());
            }
          },
          child: const Text("Custom Dialog"),
        ),
        ElevatedButton(
            onPressed: () async {
              TimeRange? result = await showCupertinoDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  TimeOfDay startTime = TimeOfDay.now();
                  TimeOfDay endTime = TimeOfDay.now();
                  return CupertinoAlertDialog(
                    content: SizedBox(
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
                              activeTimeTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: Colors.white),
                              timeTextStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 22,
                                  color: Colors.white70),
                              onStartChange: (start) {
                                setState(() {
                                  startTime = start;
                                });
                              },
                              onEndChange: (end) {
                                setState(() {
                                  endTime = end;
                                });
                              },
                            ),
                          ],
                        )),
                    actions: <Widget>[
                      CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      CupertinoDialogAction(
                        child: const Text('Ok'),
                        onPressed: () {
                          Navigator.of(context).pop(
                            TimeRange(startTime: startTime, endTime: endTime),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
              if (kDebugMode) {
                print(result.toString());
              }
            },
            child: const Text("Cupertino style"))
      ]),
    );
  }
}
