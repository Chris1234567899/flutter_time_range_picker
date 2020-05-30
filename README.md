# time_range_picker

A time range picker for flutter.

## Getting Started

- [Installation](#installation)
- [Basic Usage](#basic-usage)
- [Use Cases](#use-cases)



### Installation

Add

```bash

time_range_picker : any

```

to your pubspec.yaml, and run

```bash
flutter packages get
```

in your project's root directory.

### Basic Usage


```dart
import 'package:flutter/material.dart';

import 'package:time_range_picker/time_range_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              TimeRange result = await showTimeRangePicker(
                context: context,
              );
              print("result " + result.toString());
            },
            child: Text("Pure"),
          ),
        ));
  }
}
```

