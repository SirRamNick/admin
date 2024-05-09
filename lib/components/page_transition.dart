import 'package:flutter/material.dart';

PageRouteBuilder instantTransitionTo({required Widget page}) => PageRouteBuilder(
  pageBuilder: (context, animation1, animation2) => page,
  transitionDuration: Duration.zero,
  reverseTransitionDuration: Duration.zero,
);