

import 'dart:math';
import 'package:flutter/material.dart';

double normalizeAngle(double radians) {
  var normalized = atan2(sin(radians), cos(radians));
  normalized = normalized > 0 ? normalized : 2 * pi + normalized;
  return normalized;
}

double timeToAngle(TimeOfDay time) {
  int min = time.hour * 60 + time.minute;
  double angle = min * pi * 2 / 60 / 24;
  return normalizeAngle(angle + pi / 2);
}

double standardizeToOffsetAngle(double angle, double offsetAngle) {
  var stan = normalizeAngle(angle - offsetAngle);
  return stan == 2 * pi ? 0 : stan;
}


enum ActiveTime { Start, End }

class TimeRange {
  TimeOfDay startTime;
  TimeOfDay endTime;

  TimeRange({@required this.startTime, @required this.endTime});
}


class ClockLabel {
  double angle;
  String text;

  ClockLabel({@required this.angle, @required this.text});

  factory ClockLabel.fromDegree({@required double deg, @required String text}) {
    return ClockLabel(angle: deg * pi / 180, text: text);
  }

  factory ClockLabel.fromTime(
      {@required TimeOfDay time, @required String text}) {
    double angle = timeToAngle(time);

    return ClockLabel(angle: angle, text: text);
  }

  factory ClockLabel.fromIndex(
      {@required int idx, @required int length, @required String text}) {
    double angle = (2 * pi / length) * idx + pi / 2;

    return ClockLabel(angle: angle, text: text);
  }
}


