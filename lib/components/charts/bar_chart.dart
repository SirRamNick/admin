
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OlopscBarChart extends StatefulWidget {
  final String collectionName;
  const OlopscBarChart({
    super.key,
    required this.collectionName,
  });

  @override
  State<StatefulWidget> createState() => OlopscBarChartState();
}

class OlopscBarChartState extends State<OlopscBarChart> {
  // Widget bottomTitles(double value, TitleMeta meta) {
  //   const style = TextStyle(fontSize: 10);
  //   String text;
  //   switch (value.toInt()) {
  //     case 0:
  //       text = 'BSCS';
  //       break;
  //     case 1:
  //       text = 'May';
  //       break;
  //     case 2:
  //       text = 'Jun';
  //       break;
  //     case 3:
  //       text = 'Jul';
  //       break;
  //     case 4:
  //       text = 'Aug';
  //       break;
  //     default:
  //       text = '';
  //       break;
  //   }
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: Text(text, style: style),
  //   );
  // }

  // Widget leftTitles(double value, TitleMeta meta) {
  //   if (value == meta.max) {
  //     return Container();
  //   }
  //   const style = TextStyle(
  //     fontSize: 10,
  //   );
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: Text(
  //       meta.formattedValue,
  //       style: style,
  //     ),
  //   );
  // }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
  late final List field_state;
  late String f_state;
  late final List<Color> barColors1;
  late final List<Color> barColors2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    field_state = [
      'strongly_agree',
      'agree',
      'neutral',
      'disagree',
      'strongly_disagree'
    ];
    f_state = field_state.first;
    barColors1 = [
      Colors.green,
      Colors.blue,
      Colors.deepPurple,
      Colors.deepOrange,
      Colors.red,
    ];
    barColors2 = [
      Colors.green.shade200,
      Colors.blue.shade200,
      Colors.purple.shade200,
      Colors.orange.shade200,
      Colors.red.shade200,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 1.5,
        child: Column(
          children: [
            const Text(
              'Question',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          f_state = field_state[0];
                        });
                      },
                      child: const Text('Strongly Agree'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          f_state = field_state[1];
                        });
                      },
                      child: const Text('Agree'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          f_state = field_state[2];
                        });
                      },
                      child: const Text('Neutral'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          f_state = field_state[3];
                        });
                      },
                      child: const Text('Disagree'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          f_state = field_state[4];
                        });
                      },
                      child: const Text('Strongly Disagree'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(widget.collectionName)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}}');
                    }
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<QueryDocumentSnapshot> data = snapshot.data!.docs;
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final barsSpace = 4.0 * constraints.maxWidth / 400;
                        final barsWidth = 8.0 * constraints.maxWidth / 400;
                        return BarChart(
                          BarChartData(
                            maxY: 6000,
                            backgroundColor: Colors.blue[100],
                            alignment: BarChartAlignment.spaceAround,
                            barTouchData: BarTouchData(
                              enabled: false,
                              touchTooltipData: BarTouchTooltipData(
                                getTooltipColor: (group) => Colors.transparent,
                                tooltipPadding: EdgeInsets.zero,
                                tooltipMargin: 8,
                                getTooltipItem:
                                    (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    rod.toY.round().toString(),
                                    const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  getTitlesWidget: (value, meta) {
                                    final course =
                                        data[value.toInt()]['degree'];
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(course),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: const AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: const FlGridData(
                              show: false,
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: data.map((doc) {
                              return BarChartGroupData(
                                showingTooltipIndicators: [0, 1, 2, 3, 4],
                                x: data.indexOf(doc),
                                barsSpace: barsSpace * 2,
                                barRods: [
                                  BarChartRodData(
                                    toY: doc.get(f_state),
                                    color: Colors.transparent,
                                    width: barsWidth * 2,
                                    borderRadius: BorderRadius.circular(6),
                                    gradient: LinearGradient(
                                      colors: [
                                        barColors1[
                                            field_state.indexOf(f_state)],
                                        barColors2[
                                            field_state.indexOf(f_state)],
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
