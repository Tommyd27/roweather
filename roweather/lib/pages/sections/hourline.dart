import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../appstate.dart';
import 'package:fl_chart/fl_chart.dart';

class HourLine extends LineChart {

  
  HourLine(appstate, dataF, tooltipF, {minY, maxY}) : 
    super(() { 
      final lbd = LineChartBarData(spots: appstate.hourly.map<FlSpot>(dataF).toList());
      return LineChartData(
        minY: minY,
        maxY: maxY,
        lineBarsData: [lbd],
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
        showingTooltipIndicators: lbd.spots.map((spot) {return ShowingTooltipIndicators([LineBarSpot(lbd, 0, spot)]);}).toList(),
        lineTouchData: LineTouchData(enabled: false, handleBuiltInTouches: false, 
        touchTooltipData: LineTouchTooltipData(
          tooltipMargin: 16.0,
          tooltipPadding: EdgeInsets.all(0),
          getTooltipColor: (_) => Color(0x00000000),
          getTooltipItems: (spots) => spots.map<LineTooltipItem>(tooltipF).toList()
        )
        /*getTouchedSpotIndicator: (barData, spotIndexes) => barData.spots.map((spot) => TouchedSpotIndicatorData(
          const FlLine(
              color: Colors.pink,
            ),
            FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                //radius: 8,
                color: Colors.green,
                //strokeWidth: 2,
                strokeColor: Colors.red,
              ),
            ),
          )).toList()*/
        )
      );}(),
      duration: Duration(milliseconds: 150), // Optional
      curve: Curves.linear, // Optional
  );
}