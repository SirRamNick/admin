import 'package:admin_app/components/page_transition.dart';
import 'package:admin_app/pages/add_alumni_page.dart';
import 'package:admin_app/pages/home_page.dart';
import 'package:admin_app/pages/statistics_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Drawer adminDrawer(BuildContext context) => Drawer(
  backgroundColor: Color(0xFFE2E2E2),
  child: ListView(
    children: [
      Container(
        height: 100,
        child: DrawerHeader(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox.square(
                dimension: 40,
                child: Placeholder(),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Our Lady of Perpetual Succor College",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Alumni Tracking System",
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      TextButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Home"),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          shape: LinearBorder(),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            instantTransitionTo(HomePage())
          );
        },
      ),
      TextButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Add Alumni"),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          shape: LinearBorder(),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            instantTransitionTo(AddAlumniPage())
          );
        },
      ),
      TextButton(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Statistics"),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          shape: LinearBorder(),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            context,
            instantTransitionTo(StatisticsPage())
          );
        },
      ),
    ],
  ),
);