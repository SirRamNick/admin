import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppBar adminAppBar(BuildContext context) => AppBar(
      backgroundColor: Color(0xFFE2E2E2),
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Admin Site"),
          Text("OLOPSC Alumni Tracking System (OATS)"),
        ],
      ),
    );
