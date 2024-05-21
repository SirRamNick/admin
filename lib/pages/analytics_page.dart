import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/charts/pie_chart_1.dart';
import 'package:admin_app/components/charts/pie_chart_2.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late final FirestoreService stats = FirestoreService();

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
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Alumni Statistics",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Surveyed Alumni Based on Year Graduated",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: OlopscPieChart(
                            stream: stats.stats.snapshots(),
                          ),
                        ),
                        Expanded(
                          child: OlopscPieChart2(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

  // Stream<List<FlSpot>> fetchStats() {
  //   final CollectionReference collectionStats = FirestoreService().stats;
  //   return collectionStats.snapshots().map((QuerySnapshot querySnapshot) {
  //     final stats = querySnapshot.docs.map((doc) {
  //       final index = doc.get('year') as int;
  //       final value = doc.get('value') as int;
  //       return FlSpot(index.toDouble(), value.toDouble());
  //     }).toList();
  //     return stats;
  //   });
  // }