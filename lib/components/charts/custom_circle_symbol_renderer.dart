import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/src/text_element.dart' as text;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:servio/components/charts/line_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servio/constants/app_colors.dart';

class CustomInfoRenderer extends CircleSymbolRenderer {
  CustomInfoRenderer();

  @override
  void paint(
    ChartCanvas canvas,
    Rectangle<num> bounds, {
    List<int>? dashPattern,
    Color? fillColor,
    FillPatternType? fillPattern,
    Color? strokeColor,
    double? strokeWidthPx,
  }) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern, fillColor: fillColor, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(Rectangle(200.w, 10.w, 100.w, 35.w), fill: Color(r: kMain.red, g: kMain.green, b: kMain.blue));
    var textStyle = style.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 15;
    canvas.drawText(
      text.TextElement("${DigestLineChart.selectedDate}\n${DigestLineChart.selectedValue}", style: textStyle),
      200.w.round() + 5,
      10.w.round() + 5,
    );
  }
}
