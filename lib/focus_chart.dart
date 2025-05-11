import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FocusBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  FocusBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 30),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                int index = value.toInt();
                if (index < data.length) {
                  String date = data[index]['date'].toString().substring(5); // MM-DD
                  return Text(date, style: TextStyle(fontSize: 10));
                } else {
                  return Text('');
                }
              },
            ),
          ),
        ),
        barGroups: data.asMap().entries.map((entry) {
          int i = entry.key;
          int score = entry.value['score'];
          return BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: score.toDouble(),
                width: 14,
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          );
        }).toList(),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }
}
