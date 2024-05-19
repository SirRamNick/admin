import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  Stream<List<FlSpot>> fetchStats() {
    final CollectionReference collectionStats = FirestoreService().stats;
    return collectionStats.snapshots().map((QuerySnapshot querySnapshot) {
      final stats = querySnapshot.docs.map((doc) {
        final index = doc.get('year') as int;
        final value = doc.get('value') as int;
        return FlSpot(index.toDouble(), value.toDouble());
      }).toList();
      return stats;
    });
  }

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
                  height: screenHeight * 0.85,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Total number of Alumni',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: fetchStats(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (!snapshot.hasData) {
                              return Text('Loading Stats...');
                            }
                            final statsData = snapshot.data!;
                            return LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: statsData,
                                    isCurved: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyan,
                                        Colors.blue,
                                      ],
                                    ),
                                    barWidth: 2,
                                    isStrokeCapRound: true,
                                    dotData: const FlDotData(show: false),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.cyan,
                                          Colors.blue,
                                        ]
                                            .map(
                                              (e) => e.withOpacity(0.3),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ],
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  horizontalInterval: 1,
                                  verticalInterval: 1,
                                  getDrawingHorizontalLine: (value) {
                                    return const FlLine(
                                      color: Colors.black,
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      interval: 1,
                                      getTitlesWidget: (value, meta) {
                                        final year =
                                            int.parse(value.toStringAsFixed(0));

                                        return SideTitleWidget(
                                            child: Text(
                                              year.toString(),
                                            ),
                                            axisSide: meta.axisSide);
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 1,
                                      reservedSize: 42,
                                      getTitlesWidget: (value, meta) {
                                        final index =
                                            int.parse(value.toStringAsFixed(0));

                                        return Text(
                                          index.toString(),
                                          textAlign: TextAlign.left,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: const Color(0xff37434d),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Text(
                        'Year Graduated',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
