import 'dart:ui';

import 'package:flutter/material.dart';

import 'model.dart';

// 导出
export 'paper_painter.dart' show PaperPainter;

class PaperPainter extends CustomPainter{
PaperPainter({
    required this.lines,
  }) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  late Paint _paint;
  final List<Line> lines;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  ///根据点集绘制线
  void drawLine(Canvas canvas, Line line) {
    _paint.color = line.color;
    _paint.strokeWidth = line.strokeWidth;
    canvas.drawPoints(PointMode.polygon, line.points, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

