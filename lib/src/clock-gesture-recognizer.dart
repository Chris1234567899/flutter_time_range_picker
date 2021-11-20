import 'package:flutter/gestures.dart';

class ClockGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function panStart;
  final Function panUpdate;
  final Function panEnd;

  ClockGestureRecognizer(
      {required this.panStart, required this.panUpdate, required this.panEnd});

  @override
  void addPointer(PointerEvent event) {
    if (panStart(event)) {
      startTrackingPointer(event.pointer);
      resolve(GestureDisposition.accepted);
    } else {
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerMoveEvent) {
      panUpdate(event);
    }
    if (event is PointerUpEvent) {
      panEnd(event);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'customPan';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
