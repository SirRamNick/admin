import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

AppBar adminAppBar = AppBar(
  backgroundColor: Color(0xFFE2E2E2),
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text("Admin Site"),
      const Text("OLOPSC Alumni Tracking System (OATS)"),
    ],
  ),
);
