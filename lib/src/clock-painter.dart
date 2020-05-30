import 'dart:math';

import 'package:flutter/material.dart';
import 'package:time_range_picker/src/utils.dart';

class ClockPainter extends CustomPainter {
  double startAngle;
  double endAngle;

  double disabledStartAngle;
  double disabledEndAngle;
  ActiveTime activeTime;

  double sweepAngle;
  double radius;

  double strokeWidth;
  double handlerRadius;
  Color strokeColor;
  Color handlerColor;
  Color selectedColor;
  Color backgroundColor;
  Color disabledColor;
  PaintingStyle paintingStyle;

  Offset _startHandlerPosition;
  Offset _endHandlerPosition;

  int ticks;
  double ticksOffset;
  double ticksLength;
  double ticksWidth;
  Color ticksColor;
  List<ClockLabel> labels;
  TextStyle labelStyle;
  double labelOffset;
  bool rotateLabels;
  bool autoAdjustLabels;
  TextPainter _textPainter;
  get startHandlerPosition {
    return _startHandlerPosition;
  }

  get endHandlerPosition {
    return _endHandlerPosition;
  }

  ClockPainter(
      {@required this.startAngle,
      @required this.endAngle,
      @required this.disabledStartAngle,
      @required this.disabledEndAngle,
      @required this.activeTime,
      @required this.radius,
      @required this.strokeWidth,
      @required this.handlerRadius,
      @required this.strokeColor,
      @required this.handlerColor,
      @required this.selectedColor,
      @required this.backgroundColor,
      @required this.disabledColor,
      @required this.paintingStyle,
      @required this.ticks,
      @required this.ticksOffset,
      @required this.ticksLength,
      @required this.ticksWidth,
      @required this.ticksColor,
      @required this.labels,
      @required this.labelStyle,
      @required this.labelOffset,
      @required this.rotateLabels,
      @required this.autoAdjustLabels});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = paintingStyle
      ..strokeWidth = strokeWidth
      ..color = backgroundColor
      ..strokeCap = StrokeCap.butt
      ..isAntiAlias = true;

    var rect = Rect.fromLTRB(0, 0, radius * 2, radius * 2);

    canvas.drawCircle(rect.center, radius, paint);

    if (disabledStartAngle != null && disabledEndAngle != null) {
      paint.color = disabledColor;
      var start = normalizeAngle(disabledStartAngle);
      var end = normalizeAngle(disabledEndAngle);
      var sweep = calcSweepAngle(start, end);

      canvas.drawArc(
          rect, start, sweep, paintingStyle == PaintingStyle.fill, paint);
    }

    if (ticks != null)
      drawTicks(
        paint,
        canvas,
      );

    paint.color = strokeColor;
    paint.strokeWidth = strokeWidth;
    if (startAngle != null && endAngle != null) {
      var start = normalizeAngle(startAngle);
      var end = normalizeAngle(endAngle);
      var sweep = calcSweepAngle(start, end);

      canvas.drawArc(
          rect, start, sweep, paintingStyle == PaintingStyle.fill, paint);

      drawHandler(paint, canvas, ActiveTime.Start, start);
      drawHandler(paint, canvas, ActiveTime.End, end);
    }

    if (labels != null)
      drawLabels(
        paint,
        canvas,
      );

    canvas.save();
    canvas.restore();
  }

  void drawHandler(Paint paint, Canvas canvas, ActiveTime type, double angle) {
    paint.style = PaintingStyle.fill;
    paint.color = handlerColor;
    if (activeTime == type) {
      paint.color = selectedColor;
    }

    Offset handlerPosition = calcCoords(radius, radius, angle, radius);
    canvas.drawCircle(handlerPosition, handlerRadius, paint);

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawCircle(handlerPosition, handlerRadius * 1.5, paint);

    if (type == ActiveTime.Start)
      _startHandlerPosition = handlerPosition;
    else
      _endHandlerPosition = handlerPosition;
  }

  void drawTicks(
    Paint paint,
    Canvas canvas,
  ) {
    var r = radius + ticksOffset - strokeWidth / 2;
    paint.color = ticksColor;
    paint.strokeWidth = ticksWidth;
    List.generate(ticks, (i) => i + 1).forEach((i) {
      double angle = (360 / ticks) * i * pi / 180;

      canvas.drawLine(calcCoords(radius, radius, angle, r),
          calcCoords(radius, radius, angle, r + ticksLength), paint);
    });
  }

  void drawLabels(
    Paint paint,
    Canvas canvas,
  ) {
    labels.forEach((label) {
      drawText(
          canvas,
          paint,
          label.text,
          calcCoords(radius, radius, label.angle, radius + labelOffset),
          label.angle);
    });
  }

  void drawText(
      Canvas canvas, Paint paint, String text, Offset position, double angle) {
    angle = normalizeAngle(angle);
    TextSpan span = new TextSpan(
      text: text,
      style: labelStyle,
    );
    _textPainter = new TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();
    Offset drawCenter =
        Offset(-(_textPainter.width / 2), -(_textPainter.height / 2));

    if (rotateLabels) {
      bool flipLabel = false;
      if (autoAdjustLabels) {
        if (angle > 0 && angle < pi) {
          flipLabel = true;
        }
      }

      // get the width of the word
      var wordWidth = _textPainter.width;

      //the total distance from center of circle
      var dist = (radius + labelOffset);

      // accumulat the offset of the letter within the word
      double lengthOffset = 0;

      // if flip, reverse letter order
      var chars = !flipLabel ? text.runes : text.runes.toList().reversed;

      chars.forEach((char) {
        // put char to textpainter
        prepareTextPainter(String.fromCharCode(char));

        // the angle where the letter appears on the circle
        final double curveAngle = angle - (wordWidth / 2 - lengthOffset) / dist;

        double letterAngle = curveAngle + pi / 2;

        // flip 180°
        if (flipLabel) letterAngle = letterAngle + pi;

        // the position of the letter on the circle
        final Offset letterPos = calcCoords(radius, radius, curveAngle, dist);

        // adjust alignment of the letter (vertically centered)
        drawCenter = Offset(
            flipLabel ? -_textPainter.width : 0, -(_textPainter.height / 2));

        //move canvas to letter position
        canvas.translate(letterPos.dx, letterPos.dy);

        //rotate canvas to letter rotation
        canvas.rotate(letterAngle);

        // paint letter
        _textPainter.paint(canvas, drawCenter);

        //undo movements
        canvas.rotate(-letterAngle);
        canvas.translate(-letterPos.dx, -letterPos.dy);

        //increase letter offset
        lengthOffset += _textPainter.width;
      });
    } else {
      _textPainter.paint(canvas, position + drawCenter);
    }
  }

  /// Calculates width and central angle for the provided [letter].
  void prepareTextPainter(String letter) {
    _textPainter.text = TextSpan(text: letter, style: labelStyle);
    _textPainter.layout();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;

  /// get the position on the circle for certain [angle]
  Offset calcCoords(double cx, double cy, double angle, double radius) {
    double x = cx + radius * cos(angle);
    double y = cy + radius * sin(angle);
    return Offset(x, y);
  }

  double calcSweepAngle(double init, double end) {
    if (end > init) {
      return end - init;
    } else
      return 2 * pi - (end - init).abs();
  }
}
