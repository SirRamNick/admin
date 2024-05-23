import 'package:admin_app/components/admin_appbar.dart';
import 'package:admin_app/components/admin_drawer.dart';
import 'package:admin_app/components/charts/bar_chart.dart';
import 'package:admin_app/services/firebase.dart';
import 'package:flutter/material.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late final FirestoreService stats = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: adminAppBar(context),
      drawer: adminDrawer(context),
      backgroundColor: const Color(0xFFE2E2E2),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Analytics",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Surveyed Alumni Based on Year Graduated",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                OlopscBarChart(
                  collectionName: 'question_2',
                ),
                OlopscBarChart(
                  collectionName: 'question_3',
                ),
                OlopscBarChart(
                  collectionName: 'question_5',
                ),
                OlopscBarChart(
                  collectionName: 'question_6',
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