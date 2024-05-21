import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HourLine extends LineChart {

  // constructor calls parent constructor with a generated LineChartData
  HourLine(appstate, dataF, tooltipF, {minY, maxY, showLine=true}) : 
    super(() { 
      final lbd = LineChartBarData(spots: appstate.hourly.map<FlSpot>(dataF).toList(), show: showLine);
      return LineChartData(
        minY: minY,
        maxY: maxY,
        lineBarsData: [lbd],
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
        // show all tooltips at each spot
        showingTooltipIndicators: lbd.spots.map((spot) {return ShowingTooltipIndicators([LineBarSpot(lbd, 0, spot)]);}).toList(),
        lineTouchData: LineTouchData(enabled: false, handleBuiltInTouches: false, 
          // tooltip styling
          touchTooltipData: LineTouchTooltipData(
            tooltipMargin: 16.0,
            tooltipPadding: EdgeInsets.all(0),
            getTooltipColor: (_) => Color(0x00000000),
            getTooltipItems: (spots) => spots.map<LineTooltipItem>(tooltipF).toList()
          )
        )
      );}(),
      duration: Duration(milliseconds: 150), // Optional
      curve: Curves.linear, // Optional
  );
}