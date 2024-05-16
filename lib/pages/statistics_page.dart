import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      backgroundColor: Color(0xFFE2E2E2),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Alumni Statistics",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  "Surveyed Alumni Based on Year Graduated",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.8,
                  child: LineChart(LineChartData(
                      backgroundColor: Colors.white,
                      borderData: FlBorderData(),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              const style = TextStyle(fontSize: 16);
                              Widget text;
                              switch (value.toInt()) {
                                case 1:
                                  text = const Text(
                                    '2024',
                                    style: style,
                                  );
                                  break;
                                case 2:
                                  text = const Text(
                                    '2025',
                                    style: style,
                                  );
                                  break;
                                case 3:
                                  text = const Text(
                                    '2026',
                                    style: style,
                                  );
                                  break;
                                case 4:
                                  text = const Text(
                                    '2027',
                                    style: style,
                                  );
                                default:
                                  text = const Text('');
                                  break;
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 10,
                                child: text,
                              );
                            },
                          ),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: <FlSpot>[
                            const FlSpot(1, 1),
                            const FlSpot(2, 2),
                            const FlSpot(3, 3),
                            const FlSpot(4, 4),
                          ],
                          barWidth: 2,
                          color: Colors.blue,
                        )
                      ])),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
