import 'package:flutter/material.dart';

class PlannerActivity {
  String title;
  TimeOfDay startTime;
  TimeOfDay endTime;

  PlannerActivity({
    required this.title,
    required this.startTime,
    required this.endTime,
  });
}
