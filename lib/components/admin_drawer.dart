import 'dart:html';
import 'dart:io';

import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/add_alumni_page.dart';
import 'package:admin_app/pages/home_page.dart';
import 'package:admin_app/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Drawer adminDrawer(BuildContext context) => Drawer(
      backgroundColor: Color(0xFFE2E2E2),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox.square(
                              dimension: 50,
                              child: Image.network(
                                'https://lh3.googleusercontent.com/d/1O2POF0-t3i3tnRK0rp7MQ06PhGAgUZ8T',
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Our Lady of Perpetual Succor College",
                                  style: TextStyle(fontSize: 11),
                                ),
                                Text(
                                  "Alumni Tracking System",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: LinearBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context, instantTransitionTo(HomePage()));
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Home"),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: LinearBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context, instantTransitionTo(AddAlumniPage()));
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Add Alumni"),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: LinearBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context, instantTransitionTo(StatisticsPage()));
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Statistics"),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: LinearBorder(),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    showAboutDialog(
                      context: context,
                      applicationName: 'OLOPSC Alumni Tracking System (Admin Site)',
                      children: [
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Team Adviser",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "Rame Nicholas Tiongson",
                              style: TextStyle(
                                fontSize: 18,
                              )
                            ),
                            SizedBox(height: 10),
                            Text(
                              "System Analyst",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Rovic Xavier Aliman"),
                            SizedBox(height: 5),
                            Text(
                              "Documentations Specialist",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Amparito Orticio"),
                            SizedBox(height: 5),
                            Text(
                              "System Designer",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Marvin Uneta"),
                            SizedBox(height: 5),
                            Text(
                              "Developers",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text("Jaydee Moles"),
                            Text("Maverick Malala"),
                            SizedBox(height: 15),
                            Text(
                              "(c) OLOPSC Computer Society 2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "All rights reserved",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ]
                    );
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("About OATS"),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Developed by:",
                        style: TextStyle(fontSize: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Image.network(
                          height: 30,
                          width: 30,
                          // 'https://lh3.googleusercontent.com/d/1JCZpxJZo4on_pmzjHuZ3Ce936sCaVEwI',
                          // 'https://lh3.googleusercontent.com/d/15SafJMjyBBCwbrMl7qhK2NPc_b-mpRrp',
                          'https://lh3.googleusercontent.com/d/1Pz_SwGksX7CXTW-XV2-BQ3GntptnQM3y',
                        ),
                      ),
                      const Text(
                        "OLOPSC Computer Society",
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
