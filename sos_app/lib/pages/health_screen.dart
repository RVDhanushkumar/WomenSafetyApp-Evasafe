import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Health Metrics',
          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 73, 136),
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 37, 52, 75),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Blood Pressure (mm Hg)'),
              SizedBox(height: 200, child: BpGraph()), // BP Graph widget
              const SizedBox(height: 32),
              _buildSectionTitle('Steps Count'),
              SizedBox(height: 200, child: StepsGraph()), // Steps Graph widget
              const SizedBox(height: 32),
              // You can add more graphs or metrics here.
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// BP Graph Widget
class BpGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        backgroundColor: Colors.grey[850],
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Day ${value.toInt()}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, _) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 120),
              FlSpot(1, 130),
              FlSpot(2, 115),
              FlSpot(3, 140),
              FlSpot(4, 150),
              FlSpot(5, 135),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.redAccent.withOpacity(0.8), Colors.redAccent],
            ),
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.red.withOpacity(0.2), Colors.redAccent.withOpacity(0)],
              ),
            ),
            dotData: FlDotData(show: false),
          ),
          LineChartBarData(
            spots: [
              FlSpot(0, 80),
              FlSpot(1, 85),
              FlSpot(2, 75),
              FlSpot(3, 90),
              FlSpot(4, 95),
              FlSpot(5, 85),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [Colors.blueAccent.withOpacity(0.8), Colors.blueAccent],
            ),
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.blue.withOpacity(0.2), Colors.blueAccent.withOpacity(0)],
              ),
            ),
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}

// Steps Graph Widget
class StepsGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        backgroundColor: Colors.grey[850],
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.white.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, _) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Day ${value.toInt()}',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, _) {
                return Text(
                  '${value.toInt() * 1000}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 5,
                gradient: LinearGradient(
                  colors: [Colors.greenAccent.withOpacity(0.8), Colors.greenAccent],
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 7,
                gradient: LinearGradient(
                  colors: [Colors.greenAccent.withOpacity(0.8), Colors.greenAccent],
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 6,
                gradient: LinearGradient(
                  colors: [Colors.greenAccent.withOpacity(0.8), Colors.greenAccent],
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 8,
                gradient: LinearGradient(
                  colors: [Colors.greenAccent.withOpacity(0.8), Colors.greenAccent],
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 4,
            barRods: [
              BarChartRodData(
                toY: 10,
                gradient: LinearGradient(
                  colors: [Colors.greenAccent.withOpacity(0.8), Colors.greenAccent],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
